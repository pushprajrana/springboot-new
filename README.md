# 🚀 Spring Boot BankApp Deployment (Docker + MySQL + EC2)

A step-by-step deployment guide to run a Spring Boot application connected to MySQL, containerized using Docker, and hosted on AWS EC2.

---

## 1️⃣ EC2 Instance Setup

**Launch EC2 Ubuntu Instance:**
- **OS**: Ubuntu 20.04
- **Instance Type**: t2.micro
- **Storage**: 30 GB
- **Ports to Allow**: 22 (SSH), 8080 (App), 3306 (MySQL)

<img width="1840" height="895" alt="Image" src="https://github.com/user-attachments/assets/e99d83c8-1749-4934-9867-1c50028e07d9" />

---

## 2️⃣ Install Docker on EC2

```bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
docker --version
```

---

## 3️⃣ Clone the GitHub Repository

```bash
git clone https://github.com/pushprajrana/springboot-new.git
cd springboot-new
```

---

## 4️⃣ Create Dockerfile (Multi-Stage Build)

```Dockerfile
# syntax=docker/dockerfile:1

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
```

---

## 5️⃣ Build Docker Image

```bash
docker build -t bankapp-mini .
```

---

## 6️⃣ Create Docker Network

```bash
docker network create bankapp
```

---

## 7️⃣ Run MySQL Container

```bash
docker run -itd --name mysql \
  -e MYSQL_ROOT_PASSWORD=Test@123 \
  -e MYSQL_DATABASE=BankDB \
  --network=bankapp mysql
```

---

## 8️⃣ Run Spring Boot Container

```bash
docker run -itd --name bankapp \
  -e SPRING_DATASOURCE_USERNAME=root \
  -e SPRING_DATASOURCE_PASSWORD=Test@123 \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/BankDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC \
  --network=bankapp \
  -p 8080:8080 bankapp-mini
```

---

## 9️⃣ Check Application Logs

```bash
docker logs bankapp
```

---

## 🔟 Access Application in Browser

```url
http://<your-ec2-public-ip>:8080
```
_📌 Replace `<your-ec2-public-ip>` with your actual EC2 public IP address._

---

✅ You're now ready to deploy your full Spring Boot + MySQL application using Docker on AWS EC2!

<img width="1911" height="803" alt="Image" src="https://github.com/user-attachments/assets/d3d1ca51-aebd-4a37-8239-f222a82a6c8e" />

<img width="1899" height="882" alt="Image" src="https://github.com/user-attachments/assets/4d7741a3-9617-4d4d-8fab-12d785b12498" />

<img width="1909" height="893" alt="Image" src="https://github.com/user-attachments/assets/53072d35-65bc-437e-8912-7c0f06199fa8" />

<img width="1883" height="890" alt="Image" src="https://github.com/user-attachments/assets/c982fe16-e158-4cdd-8713-efafc7c26b93" />

<img width="1091" height="648" alt="Image" src="https://github.com/user-attachments/assets/46b64178-5279-4328-9731-e8f365291943" />



