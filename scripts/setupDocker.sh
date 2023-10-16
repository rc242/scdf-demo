dir=`dirname $0`
cd $dir/..
touch docker/nexus.admin.password
docker compose -p hello-world -f docker/docker-compose-kafka.yml -f docker/docker-compose.yml -f docker/docker-compose-postgres.yml -f docker/docker-compose-prometheus.yml up -d
