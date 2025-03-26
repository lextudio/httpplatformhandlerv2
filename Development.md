# Development Tips

## Steps to Produce Release Mode Installers

1. Install Visual Studio 2022 (C++ desktop development must be enabled).
1. Clone this repo and switch to a release tag.
1. Run `restore.cmd` to initialize.
1. Run `build.all.bat` to build everything out.

The MSI files are `artifacts\installers\Release\*.msi`.

## Steps to Set Up Local Development Environment

The steps to set up local debugging environment are (assume you are on Windows x64 with VS2022/IIS/HttpPlatformHandler v2 already installed),

1. Clone this repo.
1. Switch to a release tag (like `httpplatformhandler_v9.0.2-rc.1`).
1. Ensure VS2022 latest version is installed and execute restore.cmd.
1. Modify `build.debug.bat` to use the VS2022 edition you are using (Community or another), and execute it to build the debug bits.
1. Stop IIS via `iisreset /stop`.
1. Copy the files from `artifacts\bin\AspNetCoreModuleShim\x64\Debug` to `%ProgramFiles%\IIS\HttpPlatformHandler Module\V2` and overwrite the release bits.
1. Copy the files from `artifacts\bin\OutOfProcessRequestHandler\x64\Debug` to `%ProgramFiles%\IIS\HttpPlatformHandler Module\V2\xx.0.xxxxx` to replace the release bits.
1. Start IIS via `iisreset /start`.
1. Launch VS2022 and open `src\Servers\IIS\IISIntegration.slnf`.
1. Launch your web app in IIS and attach VS2022 debugger to the proper `w3wp.exe` process.
1. Set breakpoints in the code base to debug around.

### Typical Locations to Debug

* Breakpoints in `src/Servers/IIS/AspNetCoreModuleV2/OutOfProcessRequestHandler/forwardinghandler.cpp` can be used to debug the actual token being passed.
