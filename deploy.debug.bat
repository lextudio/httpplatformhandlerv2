@echo off
echo Copying ASP.NET Core Module debug build files to IIS HttpPlatformHandler Module directory...

set SOURCE_DIR1=C:\Users\Administrator\source\repos\httpplatformhandlerv2\artifacts\bin\OutOfProcessRequestHandler\x64\Debug
set SOURCE_DIR2=C:\Users\Administrator\source\repos\httpplatformhandlerv2\artifacts\bin\AspNetCoreModuleShim\x64\Debug
set TARGET_DIR1=C:\Program Files\IIS\HttpPlatformHandler Module\V2\19.0.25152
set TARGET_DIR2=C:\Program Files\IIS\HttpPlatformHandler Module\V2

REM Check if source directories exist
if not exist "%SOURCE_DIR1%" (
    echo Error: Source directory not found: %SOURCE_DIR1%
    exit /b 1
)

if not exist "%SOURCE_DIR2%" (
    echo Error: Source directory not found: %SOURCE_DIR2%
    exit /b 1
)

REM Check if target directories exist, create if not
if not exist "%TARGET_DIR1%" (
    echo Target directory does not exist. Creating directory: %TARGET_DIR1%
    mkdir "%TARGET_DIR1%"
    if %errorlevel% NEQ 0 (
        echo Error: Failed to create target directory. Make sure you have administrator privileges.
        exit /b %errorlevel%
    )
)

if not exist "%TARGET_DIR2%" (
    echo Target directory does not exist. Creating directory: %TARGET_DIR2%
    mkdir "%TARGET_DIR2%"
    if %errorlevel% NEQ 0 (
        echo Error: Failed to create target directory. Make sure you have administrator privileges.
        exit /b %errorlevel%
    )
)

REM Copy OutOfProcessRequestHandler DLL and PDB files
echo Copying OutOfProcessRequestHandler files to %TARGET_DIR1%...
copy /Y "%SOURCE_DIR1%\*.dll" "%TARGET_DIR1%\"
copy /Y "%SOURCE_DIR1%\*.pdb" "%TARGET_DIR1%\"

if %errorlevel% NEQ 0 (
    echo Error: Failed to copy OutOfProcessRequestHandler files. Make sure you have administrator privileges.
    exit /b %errorlevel%
)

REM Copy AspNetCoreModuleShim DLL and PDB files
echo Copying AspNetCoreModuleShim files to %TARGET_DIR2%...
copy /Y "%SOURCE_DIR2%\*.dll" "%TARGET_DIR2%\"
copy /Y "%SOURCE_DIR2%\*.pdb" "%TARGET_DIR2%\"

if %errorlevel% NEQ 0 (
    echo Error: Failed to copy AspNetCoreModuleShim files. Make sure you have administrator privileges.
    exit /b %errorlevel%
)

echo All files copied successfully