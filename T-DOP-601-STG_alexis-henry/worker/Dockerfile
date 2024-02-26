FROM maven:3.8.4-jdk-11-slim AS builder

WORKDIR /app

COPY pom.xml ./

RUN mvn dependency:resolve

COPY src ./src

RUN mvn package
FROM openjdk:11-jre-slim

WORKDIR /app

COPY --from=builder /app/target/worker-jar-with-dependencies.jar ./

ENV REDIS_HOST=redis
ENV DB_HOST=db
ENV DB_USER=postgres
ENV DB_PASSWORD=password

CMD ["java", "-jar", "worker-jar-with-dependencies.jar"]