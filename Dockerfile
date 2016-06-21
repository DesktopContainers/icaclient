FROM desktopcontainers/base-debian

ENV icaclient_version 13.3.0.344519

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q -y update && \
    apt-get -q -y install wget \
                          iceweasel \
                          net-tools && \
    apt-get -q -y install libxmu6 \
                          libwebkitgtk-1.0-0 \
                          libglu1-mesa && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN DOWNLOAD_URL=$(wget -O - https://www.citrix.com/downloads/citrix-receiver/linux/receiver-for-linux-latest.html | grep '<a' | grep 'icaclient_' | grep '_amd64.deb' | sed -e 's,.*rel=",https:,' -e 's,".*,,g' | head -n1); \
    wget "$DOWNLOAD_URL" -O icaclient.deb && \
    dpkg --add-architecture i386 && \
    dpkg -i icaclient.deb || apt-get -q -y -f install; \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* icaclient.deb; \
    \
    ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/; \
    c_rehash /opt/Citrix/ICAClient/keystore/cacerts/; \
    \
    rm -f /usr/lib/mozilla/plugins/npica.so; \
    ln -s /opt/Citrix/ICAClient/npica.so /usr/lib/mozilla/plugins/npica.so; \
    \
    cp /opt/Citrix/ICAClient/nls/en.UTF-8/eula.txt /opt/Citrix/ICAClient/nls/en/; \
    echo 'pref("plugin.state.npica", 2);' > /usr/lib/firefox-esr/defaults/pref/icaclient.js; \
    \
    echo "#!/bin/sh\nfirefox --new-instance \$*\n" > /bin/browser.sh && \
    chmod a+x /bin/browser.sh && \
    useradd -ms /bin/browser.sh browser && \
    chown browser.browser -R /home/browser && \
    su - browser -c 'mkdir /home/browser/.ICAClient';

ADD wfclient.ini /home/browser/.ICAClient/wfclient.ini
