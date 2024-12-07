FROM nginx:stable-alpine

RUN apk update && apk add --no-cache --upgrade zlib libc6-compat curl

RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

COPY config.d/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to make the web server accessible
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]