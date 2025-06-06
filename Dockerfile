FROM alpine

RUN apk update && apk add --no-cache --upgrade zlib libc6-compat curl zip unzip
RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

RUN addgroup -g 10014 choreo && \
    adduser --disabled-password --no-create-home --uid 10014 --ingroup choreo choreouser

WORKDIR /app
RUN mkdir -p /app/data && chown -R 10014:10014 /app/data

ARG BAK_VERSION=2.0
RUN curl -L "https://github.com/laboratorys/backup-to-github/releases/download/v${BAK_VERSION}/backup2gh-v${BAK_VERSION}-linux-amd64.tar.gz" -o backup-to-github.tar.gz \
    && tar -xzf backup-to-github.tar.gz \
    && rm backup-to-github.tar.gz \
    && chmod +x backup2gh

ARG NEZHA_VERSION=1.2.6
RUN curl -L "https://github.com/nezhahq/nezha/releases/download/v${NEZHA_VERSION}/dashboard-linux-amd64.zip" -o dashboard-linux-amd64.zip \
    && unzip dashboard-linux-amd64.zip \
    && mv dashboard-linux-amd64 dashboard \
    && rm dashboard-linux-amd64.zip \
    && chmod +x dashboard

USER 10014
VOLUME /app/data  #确保数据目录是可挂载的卷
EXPOSE 8008

ENTRYPOINT ["/bin/sh", "-c", "/app/dashboard"]