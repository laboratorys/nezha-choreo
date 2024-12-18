FROM alpine

RUN apk update && apk add --no-cache --upgrade zlib libc6-compat curl zip
RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser
USER 10014
WORKDIR /app
#ARG BAK_VERSION=2.0
#ENV BAK_VERSION=${BAK_VERSION}
#RUN cd $WORKDIR && curl -L "https://github.com/laboratorys/backup-to-github/releases/download/v${BAK_VERSION}/backup2gh-v${BAK_VERSION}-linux-amd64.tar.gz" -o backup-to-github.tar.gz \
#    && tar -xzf backup-to-github.tar.gz \
#    && rm backup-to-github.tar.gz \
ARG NEZHA_VERSION=1.2.6
RUN curl -L "https://github.com/nezhahq/nezha/releases/download/v${NEZHA_VERSION}/dashboard-linux-amd64.zip" -o dashboard-linux-amd64.zip \
    && unzip dashboard-linux-amd64.zip \
    && mv dashboard-linux-amd64 dashboard \
    && chmod +x dashboard
#    && rm backup-to-github.tar.gz \
#COPY dashboard .
#RUN chmod +x /home/10014/app/dashboard
RUN mkdir "data"
COPY config.yaml data


# Expose port 80 to make the web server accessible
EXPOSE 8090

# Start Nginx when the container launches
CMD ["/app/dashboard", "-c", "/app/data/config.yaml"]