docker build -t nezha-dashboard-choreo .
docker stop nezha-dashboard-choreo
docker rm nezha-dashboard-choreo
docker run -d -p 8008:8008 --name nezha-dashboard-choreo nezha-dashboard-choreo
#docker run -d -p 8008:8008 --name nezha-dashboard ghcr.io/nezhahq/nezha
