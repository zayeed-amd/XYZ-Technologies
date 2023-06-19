# Use the official Tomcat base image
#FROM tomcat:9.0.76-jre11
FROM tomcat:latest


# Remove existing Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to the webapps directory in the container
COPY target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ABCtechnologies.war
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container is launched
CMD ["catalina.sh", "run"]
