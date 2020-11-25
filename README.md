# DesktopContainers/icaclient - Citrix ICA-Client [x86 + arm]
_Citrix ICA Client Plugin bundled with Mozilla Firefox_

Citrix icaclient is a terribly bad designed an terribly bad
implemented tool for remote desktop connections. It is a 32-bit
Firefox plugin, even on 64-bit Linux systems, so it corrupts your
operating system, or at least your Firefox installation. Even then, it
need fixes and most of the time, it does not work.  Still I have to
use it on work. So I want to run it in a well defined environment:
Encapsulate in a docker container.

It's based on [desktopcontainers/base-debian](https://github.com/DesktopContainers/base-debian)

## Changelogs

* 2020-11-25
    * removed unsupported arm64 arch

## Environment variables and defaults

- __WEB\_URL__
    - specify the url the browser will point to by default e.g. the citrix login portal url

# Usage / Help / Manual / Settings / API etc.

For more Settings look at the base container settings here: [desktopcontainers/base-debian](https://github.com/DesktopContainers/base-debian)