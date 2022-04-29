docker network create grpc-net
docker network inspect grpc-net

# grpc server
./grardlew bootJar
docker build -t grpc-server .

docker run \
  -p 9090:9090 \
  --network grpc-net \
  --name grpc-server \
  grpc-server

docker tag grpc-server:latest akshitj1/grpc-server:latest
docker push akshitj1/grpc-server:latest

# grpc client
mvn package
docker build -t grpc-client .

docker run \
  --network grpc-net \
  grpc-client

docker tag grpc-client:latest akshitj1/grpc-client:latest
docker push akshitj1/grpc-client:latest

# to force rebuild
kubectl delete pod  grpc-client-deployment-7454b7b4b-p8f6t

# cleanup
kubectl delete deployment grpc-server-deployment
kubectl delete services grpc-service
