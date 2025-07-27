#----------stage-1--------------


FROM maven:3.8.3-openjdk-17 AS builder 

WORKDIR /app 

COPY  . /app

RUN mvn clean install -DskipTests=true

#----------stage-2-----------------

FROM  openjdk:17-alpine     

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar
 
EXPOSE 80:80

ENTRYPOINT ["java" , "-jar" , "/app/target/bankapp.jar"]
