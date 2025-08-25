# syntax=docker/dockerfile:1

# ---- Build stage: uses Maven + JDK 21 to compile and package ----
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Download deps first (faster rebuilds)
COPY pom.xml .
RUN mvn -e -B -ntp -DskipTests dependency:go-offline

# Copy source and build
COPY src ./src
RUN mvn -e -B -ntp -DskipTests package

# ---- Runtime stage: small JRE 21 image to run the app ----
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/java-app-1.0-SNAPSHOT.jar /app/app.jar

# (Optional) expose if you later turn it into a web app
# EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]
