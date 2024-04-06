HttpPlatformHandler v2
======================

[![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads-pre/lextudio/httpplatformhandlerv2/total?style=flat-square)](https://github.com/lextudio/httpplatformhandlerv2/releases)
[![MIT License](https://img.shields.io/github/license/lextudio/httpplatformhandlerv2?color=%230b0&style=flat-square)](https://github.com/lextudio/httpplatformhandlerv2/blob/main/LICENSE.txt) [![Help Wanted](https://img.shields.io/github/issues/lextudio/httpplatformhandlerv2/help%20wanted?color=%232EA043&label=help%20wanted&style=flat-square)](https://github.com/lextudio/httpplatformhandlerv2/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) [![Good First Issues](https://img.shields.io/github/issues/lextudio/httpplatformhandlerv2/good%20first%20issue?color=%23512BD4&label=good%20first%20issue&style=flat-square)](https://github.com/lextudio/httpplatformhandlerv2/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)

HttpPlatformHandler was created by Microsoft Azure team and made publicly available in 2015. More history about this Microsoft product can be found [in this blog post](https://docs.lextudio.com/blog/the-rough-history-of-iis-httpplatformhandler/).

As Microsoft didn't publish any new release after v1.2 and more issues related to this old release were reported by users, there is a need to give the user community something new. Our team at LeXtudio Inc. are experienced .NET developers with extensive IIS knowledge so we decided to give this a try.

We chose to fork and build up ASP.NET Core module, which was initially a fork of HttpPlatformHandler itself, now is both open-source and well maintained by Microsoft ASP.NET Core team. By renaming many things through the code base, we are able to derive a slim module that just works for any programming languages/application servers. And most importantly we keep this new module backward compatible with HttpPlatformHandler v1.2. That's why we simply call it HttpPlatformHandler v2.

The changes we make are released under MIT.

## Get started

Find a release from [the Releases section](https://github.com/lextudio/httpplatformhandlerv2/releases) and you can see the installers (x86, x64, and ARM64).

Install them according to the IIS/IIS Express builds you are using, and then you can apply your previous knowledge/configuration of HttpPlatformHandler.

## Reporting bugs or asking questions

Bugs or questions can be reported to [the Issues section](https://github.com/lextudio/httpplatformhandlerv2/issues). 

For commercial support inquiries, please contact LeXtudio Inc. via email support@lextudio.com or our [home page](https://lextudio.com).

## Reporting security issues

Security issues should be reported privately, via email, to LeXtudio Inc. support@lextudio.com. You should receive a response within 24 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

## Code of conduct

See [CODE-OF-CONDUCT](./CODE-OF-CONDUCT.md)

## Nightly builds

This table includes links to download the latest builds of the ASP.NET Core Shared Framework. Also included are links to download the Windows Hosting Bundle, which includes the ASP.NET Core Shared Framework, the .NET Runtime Shared Framework, and the IIS plugin (ASP.NET Core Module). You can download the latest .NET Runtime builds [here](https://github.com/dotnet/runtime/blob/main/docs/project/dogfooding.md#nightly-builds-table), and the latest .NET SDK builds [here](https://github.com/dotnet/installer#table). **If you're unsure what you need, then install the SDK; it has everything except the IIS plugin.**

| Platform | Shared Framework (Installer) | Shared Framework (Binaries) | Hosting Bundle (Installer) |
| :--------- | :----------: | :----------: | :----------: |
| **Windows x64** | [Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-x64.exe) | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-x64.zip) | [Installer](https://aka.ms/dotnet/9.0/daily/dotnet-hosting-win.exe) |
| **Windows x86** | [Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-x86.exe) | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-x86.zip) | [Installer](https://aka.ms/dotnet/9.0/daily/dotnet-hosting-win.exe) |
| **Windows arm64** | [Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-arm64.exe) | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-win-arm64.zip) | [Installer](https://aka.ms/dotnet/9.0/daily/dotnet-hosting-win.exe) |
| **macOS x64** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-osx-x64.tar.gz) | **N/A** |
| **macOS arm64** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-osx-arm64.tar.gz) | **N/A** |
| **Linux x64** | [Deb Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-x64.deb) - [RPM Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-x64.rpm) | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-x64.tar.gz) | **N/A** |
| **Linux arm** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-arm.tar.gz) | **N/A** |
| **Linux arm64** | [RPM Installer](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-aarch64.rpm) | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-arm64.tar.gz) | **N/A** |
| **Linux-musl-x64** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-musl-x64.tar.gz) | **N/A** |
| **Linux-musl-arm** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-musl-arm.tar.gz) | **N/A** |
| **Linux-musl-arm64** | **N/A** | [Binaries](https://aka.ms/dotnet/9.0/daily/aspnetcore-runtime-linux-musl-arm64.tar.gz) | **N/A** |
