FROM maven:3.9.2-eclipse-temurin-20 AS build
COPY myapp /workspace/
WORKDIR /workspace
RUN mvn --batch-mode package --file myapp/pom.xml -DskipTests -DbumpPatch

FROM openjdk:14-slim
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]
