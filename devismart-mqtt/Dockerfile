ARG BUILD_FROM
FROM $BUILD_FROM AS build
ARG JAVA_VERSION=17

LABEL org.opencontainers.image.description="$(cat README.md)"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
		git \
		xmlstarlet \
		maven \
        openjdk-${JAVA_VERSION}-jre-headless \
        zip && \
    c_rehash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

RUN git clone https://github.com/igor-podpalchenko/ha-devi-mqtt
RUN mv ./ha-devi-mqtt/src ./src
RUN mv ./ha-devi-mqtt/pom.xml ./pom.xml
RUN mv ./ha-devi-mqtt/auto-discovery-templates  ./auto-discovery-templates

# change Java version to 17
RUN xmlstarlet ed --inplace -N pom=http://maven.apache.org/POM/4.0.0 -u "/pom:project/pom:properties/pom:maven.compiler.source" --value "17" ./pom.xml
RUN xmlstarlet ed --inplace -N pom=http://maven.apache.org/POM/4.0.0 -u "/pom:project/pom:properties/pom:maven.compiler.target" --value "17" ./pom.xml

# download dependencies
RUN mvn dependency:go-offline

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Create the final image to run the application
FROM $BUILD_FROM
ARG JAVA_VERSION=17

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        openjdk-${JAVA_VERSION}-jre-headless \
        zip && \
    c_rehash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
	
# Set the working directory inside the container
WORKDIR /app

# Create a directory for configuration files
RUN mkdir /app/auto-discovery-templates

# Copy the JAR file from the build stage
COPY --from=build /app/target/ha-devi-mqtt.jar ./ha-devi-mqtt.jar
COPY --from=build /app/auto-discovery-templates /app/auto-discovery-templates

# Expose volume with configuration and userdata dir
VOLUME /config

CMD ["java", "-cp", "ha-devi-mqtt.jar", "io.homeassistant.devi.mqtt.service.ConsoleRunner", "--auto-discovery-templates", "/app/auto-discovery-templates", "--mqtt-config", "/config/mqtt_config.json", "--devi-config", "/config/devi_config.json"]

