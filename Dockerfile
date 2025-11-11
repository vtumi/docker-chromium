FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbullseye-8446af38-ls104

# title
ENV TITLE=Chromium

ENV CHROME_VERSION=1402768
ENV GOOGLE_API_KEY=no
ENV GOOGLE_DEFAULT_CLIENT_ID=no
ENV GOOGLE_DEFAULT_CLIENT_SECRET=no

RUN \
  echo "**** add icon ****" && \
  curl -o /kclient/public/favicon.ico https://www.chromium.org/favicon.ico && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends unzip libgtk-3-0 libnss3 libasound2 desktop-file-utils fonts-noto-cjk-extra && \
  mkdir -p /opt/chromium && \
  curl -fSL "https://github.com/vtumi/docker-chromium/releases/download/v1.0.0/chrome-linux.zip" -o /tmp/chrome.zip && \
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

RUN chmod +x /opt/chromium/chrome
RUN chmod +x /opt/chromium/chrome_crashpad_handler
RUN chmod +x /usr/bin/wrapped-chromium

# ports and volumes
EXPOSE 3000

VOLUME /config
