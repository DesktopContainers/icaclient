FROM desktopcontainers/base-debian

ENV icaclient_version 13.3.0.344519

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q -y update && \
    apt-get -q -y install wget \
                          iceweasel && \
    apt-get -q -y install libxmu6 \
                          libwebkitgtk-1.0-0 \
                          libglu1-mesa && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN DOWNLOAD_URL=$(wget -O - https://www.citrix.com/downloads/citrix-receiver/linux/receiver-for-linux-latest.html | grep '<a' | grep 'icaclient_' | grep '_amd64.deb' | sed -e 's,.*rel=",https:,' -e 's,".*,,g' | head -n1); \
    wget "$DOWNLOAD_URL" -O icaclient.deb && \
    dpkg -i icaclient.deb || apt-get -q -y -f install; \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* icaclient.deb; \
    \
    ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/; \
    c_rehash /opt/Citrix/ICAClient/keystore/cacerts/ > /dev/null; \
    \
    cp /opt/Citrix/ICAClient/nls/en.UTF-8/eula.txt /opt/Citrix/ICAClient/nls/en/; \
    echo 'pref("plugin.state.npica", 2);' > /usr/lib/firefox-esr/defaults/pref/icaclient.js; \
    \
    echo "#!/bin/bash\nfirefox --new-instance \$*\n" > /bin/ssh-app.sh && \
    mkdir /home/app/.ICAClient && \
    chown app.app -R /home/app/.ICAClient

ADD wfclient.ini /home/app/.ICAClient/wfclient.ini
