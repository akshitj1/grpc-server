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


export AWS_PROFILE=kops

export NAME=gocrazy.dealshare.co.in
export KOPS_STATE_STORE=s3://kubernetes-dealshare-com-state-storage



kubectl apply -f kubernetes.yaml

kubectl get pods
POD_NAME=grpc-server-deployment-5b4bf54b75-bxnfm
kubectl exec -ti $POD_NAME -- bash

kubectl get services
kubectl get deployments

kubectl get pod grpc-client-deployment-7454b7b4b-p8f6t --output=yaml
kubectl logs grpc-client-deployment-7454b7b4b-6qzhj

# to force rebuild
kubectl delete pod  grpc-client-deployment-7454b7b4b-p8f6t

# cleanup
kubectl delete deployment grpc-server-deployment
kubectl delete services grpc-service
