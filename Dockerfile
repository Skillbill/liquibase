FROM openjdk:8

COPY ./liquibase /usr/src/myapp/
COPY ./liquibase.jar /usr/src/myapp/
COPY ./docker-entrypoint.sh /usr/src/myapp/

COPY ./lib /usr/src/myapp/lib/

WORKDIR /usr/src/myapp

VOLUME drivers

ENV LIQUIBASE_URL="" \
    LIQUIBASE_USERNAME="" \
    LIQUIBASE_PASSWORD=""

ENTRYPOINT ["/usr/src/myapp/docker-entrypoint.sh"]