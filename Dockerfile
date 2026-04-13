FROM tomcat:9-alpine
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY target/webapp-1.0.war /usr/local/tomcat/webapps/ROOT.war
