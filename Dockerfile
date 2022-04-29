FROM openjdk:17-jdk
EXPOSE 9090
ADD ./build/libs/grpc-server-1.0-SNAPSHOT.jar grpc-server.jar
ENTRYPOINT ["java","-jar","grpc-server.jar"]