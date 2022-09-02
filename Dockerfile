FROM openjdk:8

ENV LIQUIBASE_JAR https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.6.1/liquibase-3.6.1.jar

#ENV LIQUIBASE_JAR https://github.com/liquibase/liquibase/releases/download/v4.15.0/liquibase-core-4.15.0.jar

WORKDIR /usr/src/myapp
RUN  wget $LIQUIBASE_JAR -O liquibase.jar
COPY ./liquibase .
COPY ./docker-entrypoint.sh .
COPY ./waitdb .
COPY ./lib ./lib
COPY WaitDB.java .

RUN javac WaitDB.java
RUN mv WaitDB.class ./lib/

VOLUME /drivers

ENV LIQUIBASE_URL="" \
    LIQUIBASE_USERNAME="" \
    LIQUIBASE_PASSWORD=""

ENTRYPOINT ["/usr/src/myapp/docker-entrypoint.sh"]
