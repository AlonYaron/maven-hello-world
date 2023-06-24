FROM maven:3.9.2-eclipse-temurin-20 AS build
COPY myapp /workspace/myapp
WORKDIR /workspace
RUN mvn --batch-mode package --file myapp/pom.xml -DskipTests -DbumpPatch

FROM openjdk:14-slim
COPY --from=build /workspace/myapp/target/*.jar app.jar
EXPOSE 6379
# Add a new user "my-user" with user id 8877
RUN useradd -u 8877 myuser
# Change to non-root privilege
USER myuser
ENTRYPOINT ["java","-jar","app.jar"]
