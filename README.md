# grpc-server
Part of blog: [Calling microservice as simple as calling function: gRPC](https://medium.com/@akshit.jain/calling-microservice-as-simple-as-calling-function-grpc-7bec48c2342f)

## Run
```shell
./gradlew bootRun

# in another window
brew install grpc

grpc_cli ls localhost:9090
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService --l
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService/SayHello --l
grpc_cli type localhost:9090 org.akshit.grpcinterface.hello.Greeter
grpc_cli call localhost:9090 org.akshit.grpcinterface.hello.HelloService.SayHello 'name: "thalaiva"'
```
