# grpc-server

```shell
./gradlew bootRun

# in another window
grpc_cli ls localhost:9090
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService --l
grpc_cli ls localhost:9090 org.akshit.grpcinterface.hello.HelloService/SayHello --l
grpc_cli type localhost:9090 org.akshit.grpcinterface.hello.Greeter
grpc_cli call localhost:9090 org.akshit.grpcinterface.hello.HelloService.SayHello 'name: "thalaiva"'
```