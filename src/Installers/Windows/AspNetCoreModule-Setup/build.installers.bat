
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=x64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=ARM64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMIISExpressV2\AncmIISExpressV2.wixproj /p:Platform=x86 /p:Configuration=Release

call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMV2\AncmV2.wixproj /p:Platform=x64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMV2\AncmV2.wixproj /p:Platform=ARM64 /p:Configuration=Release
call "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\ANCMV2\AncmV2.wixproj /p:Platform=x86 /p:Configuration=Release
