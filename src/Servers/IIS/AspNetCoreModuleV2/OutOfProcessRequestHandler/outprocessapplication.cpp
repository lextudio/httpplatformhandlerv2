// Copyright (c) .NET Foundation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

#include "outprocessapplication.h"
#include "SRWExclusiveLock.h"
#include "exceptions.h"
#include <filesystem>
#include <EventLog.h>

OUT_OF_PROCESS_APPLICATION::OUT_OF_PROCESS_APPLICATION(
    IHttpApplication& pApplication,
    std::unique_ptr<REQUESTHANDLER_CONFIG> pConfig) :
    AppOfflineTrackingApplication(pApplication),
    m_fWebSocketSupported(WEBSOCKET_STATUS::WEBSOCKET_UNKNOWN),
    m_pConfig(std::move(pConfig))
{
    m_pProcessManager = NULL;
}

OUT_OF_PROCESS_APPLICATION::~OUT_OF_PROCESS_APPLICATION()
{
    SRWExclusiveLock lock(m_stopLock);
    if (m_pProcessManager != NULL)
    {
        m_pProcessManager->Shutdown();
        m_pProcessManager->DereferenceProcessManager();
        m_pProcessManager = NULL;
    }
}

HRESULT
OUT_OF_PROCESS_APPLICATION::Initialize(
)
{
    if (m_pProcessManager == NULL)
    {
        m_pProcessManager = new PROCESS_MANAGER();
        RETURN_IF_FAILED(m_pProcessManager->Initialize());
    }

    // Start monitoring files configured for recycleOnFileChange
    RETURN_IF_FAILED(StartMonitoringConfiguredFiles());

    return S_OK;
}

HRESULT
OUT_OF_PROCESS_APPLICATION::GetProcess(
    _Out_   SERVER_PROCESS       **ppServerProcess
)
{
    return m_pProcessManager->GetProcess(m_pConfig.get(), QueryWebsocketStatus(), ppServerProcess);
}

__override
VOID
OUT_OF_PROCESS_APPLICATION::StopInternal(bool fServerInitiated)
{
    // Stop all file watchers before stopping the application
    for (auto& fileWatcher : m_fileWatchers)
    {
        if (fileWatcher != nullptr)
        {
            fileWatcher->StopMonitor();
        }
    }
    m_fileWatchers.clear();

    // Call parent class implementation
    AppOfflineTrackingApplication::StopInternal(fServerInitiated);

    if (m_pProcessManager != NULL)
    {
        m_pProcessManager->Shutdown();
    }
}

HRESULT
OUT_OF_PROCESS_APPLICATION::CreateHandler(
    _In_  IHttpContext       *pHttpContext,
    _Out_ IREQUEST_HANDLER  **pRequestHandler)
{
    IREQUEST_HANDLER* pHandler = NULL;

    //add websocket check here
    if (m_fWebSocketSupported == WEBSOCKET_STATUS::WEBSOCKET_UNKNOWN)
    {
        SetWebsocketStatus(pHttpContext);
    }

    pHandler = new FORWARDING_HANDLER(pHttpContext, ::ReferenceApplication(this));
    *pRequestHandler = pHandler;
    return S_OK;
}

VOID
OUT_OF_PROCESS_APPLICATION::SetWebsocketStatus(
    IHttpContext* pHttpContext
)
{
    // Even though the applicationhost.config file contains the websocket element,
    // the websocket module may still not be enabled.
    PCWSTR pszTempWebsocketValue;
    DWORD cbLength;
    HRESULT hr = pHttpContext->GetServerVariable("WEBSOCKET_VERSION", &pszTempWebsocketValue, &cbLength);
    if (SUCCEEDED(hr))
    {
        m_fWebSocketSupported = WEBSOCKET_STATUS::WEBSOCKET_SUPPORTED;
    }
    else
    {
        m_fWebSocketSupported = WEBSOCKET_STATUS::WEBSOCKET_NOT_SUPPORTED;
        if (hr != HRESULT_FROM_WIN32(ERROR_INVALID_INDEX))
        {
            LOG_IF_FAILED(hr);
        }
    }
}

BOOL
OUT_OF_PROCESS_APPLICATION::QueryWebsocketStatus() const
{
    return m_fWebSocketSupported == WEBSOCKET_STATUS::WEBSOCKET_SUPPORTED;
}

HRESULT
OUT_OF_PROCESS_APPLICATION::StartMonitoringConfiguredFiles()
{
    // Don't monitor files if app is stopping/stopped
    if (m_fStopCalled)
    {
        return S_OK;
    }

    const auto& filesToMonitor = m_pConfig->QueryRecycleOnFileChangeFiles();
    if (filesToMonitor.empty())
    {
        // No files to monitor
        return S_OK;
    }

    LOG_INFOF(L"Starting file change monitoring for %d files in application '%ls'",
        filesToMonitor.size(), QueryApplicationPhysicalPath().c_str());

    try
    {
        for (const auto& filePath : filesToMonitor)
        {
            // Create full path if it's not already absolute
            std::wstring fullPath = filePath;
            if (!std::filesystem::path(filePath).is_absolute())
            {
                // Combine app path with relative path
                fullPath = QueryApplicationPhysicalPath() + filePath;
            }

            std::filesystem::path path(fullPath);
            std::wstring directoryPath = path.parent_path().wstring();
            std::wstring fileName = path.filename().wstring();

            auto fileWatcher = std::make_unique<FILE_WATCHER>();
            LOG_INFOF(L"Creating file watcher for '%ls' in directory '%ls'", fileName.c_str(), directoryPath.c_str());

            RETURN_IF_FAILED(fileWatcher->Create(
                directoryPath.c_str(),
                fileName.c_str(),
                L"", // No shadow copy path for file monitoring
                this,
                m_shutdownTimeout));

            m_fileWatchers.push_back(std::move(fileWatcher));
        }
    }
    catch (...)
    {
        OBSERVE_CAUGHT_EXCEPTION();
        return HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
    }

    return S_OK;
}

VOID
OUT_OF_PROCESS_APPLICATION::OnFileChanged()
{
    if (m_fStopCalled)
    {
        return;
    }

    LOG_INFOF(L"File change detected in application '%ls', triggering application restart", QueryApplicationPhysicalPath().c_str());

    EventLog::Info(
        ASPNETCORE_EVENT_RECYCLE_CONFIGURATION,
        ASPNETCORE_EVENT_RECYCLE_FILECHANGE_MSG,
        QueryApplicationPhysicalPath().c_str());

    // Stopping the application will cause IIS to recycle it
    Stop(/*fServerInitiated*/ false);
}
