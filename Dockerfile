FROM alpine

RUN apk update && apk add --no-cache --upgrade zlib libc6-compat curl zip
RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

WORKDIR /app
ARG BAK_VERSION=2.0
RUN cd $WORKDIR && curl -L "https://github.com/laboratorys/backup-to-github/releases/download/v${BAK_VERSION}/backup2gh-v${BAK_VERSION}-linux-amd64.tar.gz" -o backup-to-github.tar.gz \
    && tar -xzf backup-to-github.tar.gz \
    && rm backup-to-github.tar.gz \
    &&  && chmod +x backup2gh
ARG NEZHA_VERSION=1.2.6
RUN curl -L "https://github.com/nezhahq/nezha/releases/download/v${NEZHA_VERSION}/dashboard-linux-amd64.zip" -o dashboard-linux-amd64.zip \
    && unzip dashboard-linux-amd64.zip \
    && mv dashboard-linux-amd64 dashboard \
    && chmod +x dashboard

RUN mkdir data

COPY config.yaml /app/data/

USER 10014
EXPOSE 8008
VOLUME ["/app/data"]
CMD ["/app/dashboard"]