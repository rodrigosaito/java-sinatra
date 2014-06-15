FROM rodrigosaito/java8

MAINTAINER Rodrigo Saito <rodrigo.saito@gmail.com>

ADD web/target/web-0.0.1-SNAPSHOT-war-exec.jar /app/web.jar
ADD run.sh /app/run.sh

EXPOSE 8080

ENTRYPOINT [ "/app/run.sh" ]

