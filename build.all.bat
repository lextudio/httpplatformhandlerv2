@echo off
setlocal EnableDelayedExpansion

call build.binaries.bat
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call build.installers.bat
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call pwsh -file sign.installers.ps1
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo All build and signing steps completed successfully.
exit /b 0
