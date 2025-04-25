FROM eclipse-temurin:17-jdk-jammy as builder
WORKDIR /workspace
COPY . .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /workspace/target/*.jar app.jar

# Configuration critique pour Render
EXPOSE 8084
ENV SERVER_PORT=8084
ENV SERVER_ADDRESS=0.0.0.0

ENTRYPOINT ["java", "-jar", "app.jar"]
