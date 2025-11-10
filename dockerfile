FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app

ENV SPRING_DATASOURCE_URL=jdbc:postgresql://dpg-d48jvimmcj7s73e0pbv0-a.oregon-postgres.render.com:5432/banco_java_sprint4?sslmode=require
ENV SPRING_DATASOURCE_USERNAME=banco_java_sprint4_user
ENV SPRING_DATASOURCE_PASSWORD=QcWhzHNUmDTKiEflNUOAzh7fEKzQmbGw

ENV SPRING_FLYWAY_ENABLED=false
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update

COPY --from=build /app/target/mottu-track-api-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]
