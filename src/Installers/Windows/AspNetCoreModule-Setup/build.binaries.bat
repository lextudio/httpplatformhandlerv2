
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=x64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=ARM64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\AspNetCore\AspNetCore.vcxproj /p:Platform=Win32 /p:Configuration=Release

call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=x64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=ARM64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" ..\..\..\Servers\IIS\AspNetCoreModuleV2\OutOfProcessRequestHandler\OutOfProcessRequestHandler.vcxproj /p:Platform=Win32 /p:Configuration=Release