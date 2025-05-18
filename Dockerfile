FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# title
ENV TITLE=Chromium

RUN \
  echo "**** add icon ****" && \
  curl -o /kclient/public/favicon.ico https://www.chromium.org/favicon.ico && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends unzip libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libgtk-3-0 libnss3 libxss1 libasound2 desktop-file-utils fonts-noto-cjk-extra && \
  mkdir -p /opt/chromium && \
  CHROME_VERSION=$(curl -s https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/LAST_CHANGE) && \
  curl -fSL "https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/${CHROME_VERSION}/chrome-linux.zip" -o /tmp/chrome.zip && \
  unzip /tmp/chrome.zip -d /tmp && \
  mv /tmp/chrome-linux/* /opt/chromium/ && \
  fc-cache -fv && \
  sed -i "s/UI.initSetting('enable_ime', false)/UI.initSetting('enable_ime', true)/" /usr/local/share/kasmvnc/www/dist/main.bundle.js && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

RUN chmod +x /usr/bin/wrapped-chromium

# ports and volumes
EXPOSE 3000

VOLUME /config