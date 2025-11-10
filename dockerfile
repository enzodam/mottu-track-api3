# 1ª etapa: build
FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app

# copia o pom e baixa dependências
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

# copia o código e builda
COPY src ./src
RUN mvn -B clean package -DskipTests

# 2ª etapa: imagem final, leve
FROM eclipse-temurin:21-jre
WORKDIR /app

# copia o jar gerado
COPY --from=build /app/target/*.jar app.jar
