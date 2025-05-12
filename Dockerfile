FROM alpine:3.21

RUN apk upgrade --no-cache --available \
    && apk add --no-cache \
      chromium-swiftshader \
      ttf-freefont \
      font-noto-emoji

COPY local.conf /etc/fonts/local.conf

ENTRYPOINT ["chromium-browser", "--headless", "--no-sandbox"]
