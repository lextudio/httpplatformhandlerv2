
@echo off
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild -find MSBuild\\**\\Bin\\MSBuild.exe`) do set MSBUILD_PATH=%%i
if not defined MSBUILD_PATH (
    echo MSBuild not found via vswhere.
    exit /b 1
)
"%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=x64 /p:Configuration=Debug
"%MSBUILD_PATH%" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=x64 /p:Configuration=Debug
