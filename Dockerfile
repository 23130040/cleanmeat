FROM gradle:9.4.1-jdk25 AS build

WORKDIR /app

COPY . .

RUN gradle clean build -x test

FROM tomcat:10.1-jdk25

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
