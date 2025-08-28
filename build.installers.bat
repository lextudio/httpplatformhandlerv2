REM Use vswhere to locate MSBuild.exe
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild -find MSBuild\\**\\Bin\\MSBuild.exe`) do set MSBUILD_PATH=%%i

if not defined MSBUILD_PATH (
    echo Could not find MSBuild.exe via vswhere. Please ensure Visual Studio is installed.
    exit /b 1
)

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /t:restore
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /t:clean /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /t:clean /p:Platform=arm64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /t:clean /p:Platform=x86 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=arm64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=x86 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /t:restore
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /t:clean /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /t:clean /p:Platform=arm64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /t:clean /p:Platform=x86 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /p:Platform=x64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /p:Platform=arm64 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call "%MSBUILD_PATH%" src\Installers\Windows\AspNetCoreModule-Setup\ANCMV2\AncmV2.wixproj /p:Platform=x86 /p:Configuration=Release
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo All installer builds completed successfully.
exit /b 0
