// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#pragma once

#include "AppOfflineTrackingApplication.h"
#include <vector>

class OUT_OF_PROCESS_APPLICATION : public AppOfflineTrackingApplication
{
    enum WEBSOCKET_STATUS
    {
        WEBSOCKET_UNKNOWN = 0,
        WEBSOCKET_NOT_SUPPORTED,
        WEBSOCKET_SUPPORTED,
    };

public:
    OUT_OF_PROCESS_APPLICATION(
        IHttpApplication& pApplication,
        std::unique_ptr<REQUESTHANDLER_CONFIG> pConfig);

    __override
    ~OUT_OF_PROCESS_APPLICATION() override;

    HRESULT
    Initialize();

    HRESULT
    GetProcess(
        _Out_   SERVER_PROCESS       **ppServerProcess
    );

    __override
    VOID
    StopInternal(bool fServerInitiated)
    override;

    __override
    HRESULT
    CreateHandler(
        _In_  IHttpContext       *pHttpContext,
        _Out_ IREQUEST_HANDLER   **pRequestHandler)
    override;

    BOOL
    QueryWebsocketStatus()
    const;

    REQUESTHANDLER_CONFIG* QueryConfig()
    {
        return m_pConfig.get();
    }

    VOID
    OnFileChanged();
    
    // Override OnConfigurationFileChange from base class
    __override
    VOID
    OnConfigurationFileChange() override
    {
        // When a configuration file changes, call OnFileChanged
        OnFileChanged();
    }

    HRESULT
    StartMonitoringConfiguredFiles();

private:

    VOID SetWebsocketStatus(IHttpContext *pHttpContext);

    PROCESS_MANAGER * m_pProcessManager;
    IHttpServer      *m_pHttpServer;

    WEBSOCKET_STATUS              m_fWebSocketSupported;
    std::unique_ptr<REQUESTHANDLER_CONFIG> m_pConfig;
    std::vector<std::unique_ptr<FILE_WATCHER>> m_fileWatchers;
};
