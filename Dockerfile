# Etapa de construcción (opcional si ya tienes el .jar listo)
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Imagen final
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
WORKDIR /app

# Copiamos el .jar construido (ajusta el nombre si es necesario)
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto que usa tu aplicación (por defecto Spring Boot usa el 8080)
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java","-jar","app.jar"]
