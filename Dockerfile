FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Chromium

ENV GOOGLE_API_KEY=no
ENV GOOGLE_DEFAULT_CLIENT_ID=no
ENV GOOGLE_DEFAULT_CLIENT_SECRET=no

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends libgtk-3-0 libnss3 libasound2 desktop-file-utils fonts-noto-cjk-extra && \
  mkdir -p /opt/chromium && \
  curl -L -o /tmp/chromium.tar.gz "https://github.com/vtumi/docker-chromium/releases/download/v1.0.0/chromium-linux.tar.gz" && \
  tar zxvf /tmp/chromium.tar.gz -C /tmp && \
  mv /tmp/chromium/* /opt/chromium/ && \
  cp /opt/chromium/product_logo_48.png /usr/share/selkies/www/icon.png && \
  fc-cache -fv && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
