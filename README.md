# grpc-server

## Run

```shell
./gradlew bootRun

# in another window

# call with curl
grpc_cli call localhost:9090 org.akshit.grpcinterface.hello.HelloService.SayHello 'name: "thalaiva"'

# explore about service
grpc_cli ls localhost:9090
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService --l
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService/SayHello --l
grpc_cli type localhost:9090 org.akshit.grpcinterface.hello.Greeter
```

## Build
### local
#### using locally published `grpc-interface`
```shell
# First use local publish instructions in grpc-interface repo. then:
./gradlew build
```
#### using remotely published `grpc-interface`

```shell
export CODEARTIFACT_AUTH_TOKEN=`\
  aws codeartifact get-authorization-token \
  --domain akshit \
  --query authorizationToken \
  --output text`

./gradlew build
```

### with docker
This will use remote `grpc-interface` library, published by us
```shell
export CODEARTIFACT_AUTH_TOKEN=`\
  aws codeartifact get-authorization-token \
  --domain akshit \
  --query authorizationToken \
  --output text`

docker build \
  --build-arg CODEARTIFACT_AUTH_TOKEN=${CODEARTIFACT_AUTH_TOKEN} \
  -t grpc-server \
  .

docker run -d -p 9090:9090 grpc-server
```