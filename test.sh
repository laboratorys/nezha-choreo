docker stop nezha-v1-cf
docker rm nezha-v1-cf
docker run -d -p 8089:80 --name nezha-v1-cf nezha-v1-cf
