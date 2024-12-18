docker stop nezha-dashboard-choreo
docker rm nezha-dashboard-choreo
docker run -d -p 8090:8090 --name nezha-dashboard-choreo nezha-dashboard-choreo
