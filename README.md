HTTP Bridge Module for IIS
==========================

[![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads-pre/lextudio/httpbridge/total?style=flat-square)](https://github.com/lextudio/httpbridge/releases)
[![MIT License](https://img.shields.io/github/license/lextudio/httpbridge?color=%230b0&style=flat-square)](https://github.com/lextudio/httpbridge/blob/main/LICENSE.txt) [![Help Wanted](https://img.shields.io/github/issues/lextudio/httpbridge/help%20wanted?color=%232EA043&label=help%20wanted&style=flat-square)](https://github.com/lextudio/httpbridge/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) [![Good First Issues](https://img.shields.io/github/issues/lextudio/httpbridge/good%20first%20issue?color=%23512BD4&label=good%20first%20issue&style=flat-square)](https://github.com/lextudio/httpbridge/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)

HttpPlatformHandler was created by Microsoft Azure team and made publicly available in 2015. More history about this Microsoft product can be found [in this blog post](https://docs.lextudio.com/blog/the-rough-history-of-iis-httpplatformhandler/).

As Microsoft didn't publish any new release after v1.2 and more issues related to this old release were reported by users, there is a need to give the user community something new. Our team at LeXtudio Inc. are experienced .NET developers with extensive IIS knowledge so we decided to give this a try.

We chose to fork and build upon ASP.NET Core module, which was initially a fork of HttpPlatformHandler itself, now is both open-source and well maintained by Microsoft ASP.NET Core team. By renaming many things through the code base, we are able to derive a slim module that just works for any programming languages/application servers. And most importantly we keep this new module backward compatible with HttpPlatformHandler v1.2. We used to call this project "HttpPlatformHandler v2" but now prefer to rename it to "HTTP Bridge Module for IIS" to better reflect its role as a generic bridging/compatibility layer and to avoid future confusion with any Microsoft offerings.

"HTTP Bridge Module" is a drop‑in replacement for the original Microsoft HttpPlatformHandler 1.2 with continued community maintenance. The existing configuration schema remain unchanged so existing deployments can adopt the new module without altering their configuration files.

The changes we make are released under the MIT license.

## Get started

Find a release from [the Releases section](https://github.com/lextudio/httpbridge/releases) and you can see the installers (x86, x64, and ARM64).

Install them accordingly to the IIS/IIS Express builds you are using, and then you can apply your previous knowledge/configuration of HttpPlatformHandler with this new HTTP Bridge Module. Existing `httpPlatform` schema elements continue to work.

## FAQ

### Why was the project renamed?

"HttpPlatformHandler v2" mimicked the original Microsoft product name and risked future confusion if Microsoft ships an updated official module. "HTTP Bridge Module for IIS" emphasizes its role as a community-maintained compatibility and bridging layer between IIS and arbitrary application servers while retaining full backward compatibility. For seamless upgrades we intentionally keep the original configuration schema names so existing `web.config` files do not require edits.

### Do I need to change my existing configuration?

No. Continue to use the existing `httpPlatform` section and attributes. Only project documentation and branding changed.

## Reporting bugs or asking questions

Bugs or questions can be reported to [the Issues section](https://github.com/lextudio/httpbridge/issues).

For commercial support inquiries, please contact LeXtudio Inc. via email support@lextudio.com or our [home page](https://lextudio.com).

## Reporting security issues

Security issues should be reported privately, via email, to LeXtudio Inc. support@lextudio.com. You should receive a response within 24 hours. If for some reason you do not, please follow up via email to ensure we received your original message.
