FROM maven:3.9.2-eclipse-temurin-20 AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY myapp/pom.xml /workspace
COPY myapp/src /workspace/src
RUN mvn --batch-mode package --file pom.xml -DskipTests -DbumpPatch

FROM openjdk:14-slim
COPY --from=build /workspace/target/*jar-with-dependencies.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]
