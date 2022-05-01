# syntax=docker/dockerfile:experimental
FROM gradle:7.4-jdk11
WORKDIR /app

# copy build config
COPY build.gradle settings.gradle ./

# copy source code
COPY src ./src

ARG CODEARTIFACT_AUTH_TOKEN
ENV CODEARTIFACT_AUTH_TOKEN=${CODEARTIFACT_AUTH_TOKEN}

# build
# https://www.nvisia.com/insights/optimizing-builds-with-buildkit
RUN --mount=type=cache,id=gradle,target=/home/gradle/.gradle gradle build --no-daemon

#CMD gradle bootRun.
CMD java -jar /app/build/libs/grpc-server-1.0-SNAPSHOT.jar

EXPOSE 9090