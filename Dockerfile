# Step 1: Build the Spring Boot application
# Use an official Maven image to build the application
 
# Set the working directory
 
# Copy the pom.xml and source code into the container
 
# Run Maven to build the application (creates the .jar file)
 
# Step 2: Prepare the runtime environment
# Use a slim OpenJDK image to run the application
 
# Set the working directory for the runtime container
 
# Copy the compiled jar file from the build stage
 
# Expose the port the application will run on
 
# Command to run the application

FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]
