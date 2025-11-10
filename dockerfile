FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

# baixa dependências
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

# copia o código e builda
COPY src ./src
RUN mvn -B clean package -DskipTests

# imagem final
FROM eclipse-temurin:21-jre
WORKDIR /app

# ====== CONFIG DO BANCO (Render Postgres) ======
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://dpg-d48jvimmcj7s73e0pbv0-a.oregon-postgres.render.com:5432/banco_java_sprint4?sslmode=require
ENV SPRING_DATASOURCE_USERNAME=banco_java_sprint4_user
ENV SPRING_DATASOURCE_PASSWORD=COLOCA_A_SENHA_DO_PRINT

# desliga flyway e deixa o hibernate criar/atualizar
ENV SPRING_FLYWAY_ENABLED=false
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update

# ==============================================

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]
