FROM tomcat
RUN pwd
RUN ls
RUN cd /usr/local/tomcat && ls
COPY ./target/**.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
