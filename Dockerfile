# Multi-stage docker file

# In this first stage, we are creating .jar file 
FROM maven as build  
WORKDIR /app
COPY . .
RUN mvn install 

# In this second stage, we are using the artifact(Uber.jar) generated at path /target created in stage 1. 

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9090
CMD ["java" "-jar", "Uber.jar" ] 



