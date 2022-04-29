package com.akshit.helloapp.services;

import io.grpc.stub.StreamObserver;
import net.devh.boot.grpc.server.service.GrpcService;
import org.akshit.grpcinterface.hello.HelloServiceGrpc;
import org.akshit.grpcinterface.hello.HelloWorld;

@GrpcService
public class Replier extends HelloServiceGrpc.HelloServiceImplBase{
    @Override
    public void sayHello(HelloWorld.Greeter request, StreamObserver<HelloWorld.Greeting> responseObserver) {
        String reply = String.format("Hey %s, Whats up!", request.getName());
        responseObserver.onNext(HelloWorld.Greeting.newBuilder()
                .setMessage(reply)
                .build());
        responseObserver.onCompleted();
    }
}