REM Use vswhere to locate MSBuild.exe
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild -find MSBuild\\**\\Bin\\MSBuild.exe`) do set MSBUILD_PATH=%%i

if not defined MSBUILD_PATH (
    echo Could not find MSBuild.exe via vswhere. Please ensure Visual Studio is installed.
    exit /b 1
)

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=ARM64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=Win32 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=ARM64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=Win32 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
