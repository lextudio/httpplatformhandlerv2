
call "C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=x64 /p:Configuration=Debug
call "C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe" src\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=Win32 /p:Configuration=Debug
call "C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=x64 /p:Configuration=Debug
call "C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe" src\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=Win32 /p:Configuration=Debug

call "C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe" src\Installers\Windows\AspNetCoreModule-Setup\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=x64 /p:Configuration=Debug
