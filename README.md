# Citrix ICA-Client
_Citrix ICA Client Plugin bundled with Mozilla Firefox_

Citrix icaclient is a terribly bad designed an terribly bad
implemented tool for remote desktop connections. It is a 32-bit
Firefox plugin, even on 64-bit Linux systems, so it corrupts your
operating system, or at least your Firefox installation. Even then, it
need fixes and most of the time, it does not work.  Still I have to
use it on work. So I want to run it in a well defined environment:
Encapsulate in a docker container.

It's based on __DesktopContainers/base-debian__

## ICA-Client License

The `CITRIX RECEIVER LICENSE AGREEMENT` is stored in file `LICENSE`.
You must accept the `LICENSE` if you use this docker container.

You could also download the client from:

https://www.citrix.com/downloads/citrix-receiver/linux/receiver-for-linux-latest.html

## Usage: Run the Client

### Simple SSH X11 Forwarding

Since it is an X11 GUI software, usage is in two steps:
  1. Run a background container as server or start existing one.

        docker start icaclient || docker run -d --name icaclient desktopcontainers/icaclient
        
  2. Connect to the server using `ssh -X` (as many times you want). 
     _Logging in with `ssh` automatically opens a firefox window_

        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
        -X browser@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' icaclient)
        
  3. Browse to your ICA service, start the client and enjoy.

You can configure firefox and set bookmarks. As long as you don't remove the container and you reuse the same container, all your changes persist. You could also tag and push your configuration to a registry to backup (should be your own private registry for your privacy).
