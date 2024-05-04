FROM tomcat:7.0.109-jdk8-openjdk

# Install dependencies
RUN apt-get update && apt-get install -y git unzip

# Clone the repository
RUN git clone --branch AltoroJ-3.2 https://github.com/HCL-TECH-SOFTWARE/AltoroJ /AltoroJ

# Install Gradle
RUN cd /tmp && \
    wget https://services.gradle.org/distributions/gradle-3.0-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-3.0-bin.zip && \
    rm gradle-3.0-bin.zip

# Build the project using Gradle
RUN cd /AltoroJ && /opt/gradle/gradle-3.0/bin/gradle build

# Copy the WAR file to Tomcat webapps directory
RUN cp /AltoroJ/build/libs/altoromutual.war /usr/local/tomcat/webapps

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh","run"]

# RUN Commands
#docker build -t altoromutual .
#docker run -p 8080:8080 -d --name altoromutual altoromutual
#docker stop altoromutual
#docker start altoromutual           http://localhost:8080/altoromutual