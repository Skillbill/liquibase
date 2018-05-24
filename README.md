## USE THIS IMAGE

> docker run -it -v `pwd`:/drivers -v `pwd`/liquibase.yml:/liquibase.yml --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/postgres" -e "LIQUIBASE_USERNAME=postgres" -e "LIQUIBASE_PASSWORD=mysecretpassword" skillbillsrl/liquibase update

## NOTES

### a psql server

> docker rm some-postgres

> docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres

### a psql client

> docker run -it --rm --link some-postgres:postgres postgres psql -h postgres -U postgres