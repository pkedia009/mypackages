# FROM alpine
# CMD ["echo", "Hello World! This container image is built using Github Actions!!!!"]


FROM alpine:3.14

# Install OpenJDK 11 and necessary tools
RUN apk add --no-cache openjdk11-jre-headless curl

# Create directories for our dummy JARs
RUN mkdir -p /root/.m2/repository/com/zinnia/zsor-commons/1.1.2-rc1 \
    && mkdir -p /root/.m2/repository/com/se2/damlintegration/1.1.2-rc1

# Create dummy JAR files
RUN echo "dummy content" > /root/.m2/repository/com/zinnia/zsor-commons/1.1.2-rc1/zsor-commons-1.1.2-rc1.jar \
    && echo "dummy content" > /root/.m2/repository/com/se2/damlintegration/1.1.2-rc1/damlintegration-1.1.2-rc1.jar

# Create dummy POM files
RUN echo "<project><modelVersion>4.0.0</modelVersion><groupId>com.zinnia</groupId><artifactId>zsor-commons</artifactId><version>1.1.2-rc1</version></project>" > /root/.m2/repository/com/zinnia/zsor-commons/1.1.2-rc1/zsor-commons-1.1.2-rc1.pom \
    && echo "<project><modelVersion>4.0.0</modelVersion><groupId>com.se2</groupId><artifactId>damlintegration</artifactId><version>1.1.2-rc1</version></project>" > /root/.m2/repository/com/se2/damlintegration/1.1.2-rc1/damlintegration-1.1.2-rc1.pom

# Set environment variable to use local Maven repository
ENV MAVEN_OPTS="-Dmaven.repo.local=/root/.m2/repository"

CMD ["echo", "Dummy dependencies are available in this image!"]
