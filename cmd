
docker build -t citus   -f Dockerfile.citus   .

docker ps -a | grep -v -e IMAGE | awk '{print $1}'| xargs docker rm

 docker images |grep none | awk '{print $3}' | xargs docker rmi



docker inspect coordinator| grep IPAddres | tail -1 |  grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | xargs  -U postgres   --host

docker inspect coordinator| grep IPAddres | tail -1 |  grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | xargs -I {} psql -U postgres --host={}  -c '\dx'


docker run -d  --name coordinator  citus
docker run -d  --name worker1  citus
docker run -d  --name worker2  citus

docker run -d  --name coordinator_s  citus
docker run -d  --name worker1_s  citus
docker run -d  --name worker2_s  citus
