## build
docker build -t skillbillsrl/liquibase:multifiles .

it create an image called skillbillsrl/liquibase:multifiles
Mind: the default image skillbillsrl/liquibase (aka skillbillsrl/liquibase:latest) is leave for compability reason 

## USE THIS IMAGE

Both version assume there are another docker running postgres named some-postgres.

### single file

put all the changeset into the file liquibase.yml and run

> docker run -it -v `pwd`:/drivers -v `pwd`/liquibase.yml:/liquibase.yml --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/postgres" -e "LIQUIBASE_USERNAME=postgres" -e "LIQUIBASE_PASSWORD=mysecretpassword" skillbillsrl/liquibase update

### multi files

put all the changeset into the folder changeset. The root file is liquibase.yml.
The root file can contain one or more changeset (as for the single file version) or the include directive to include how many file you want.
The run.

docker run -it -v `pwd`:/drivers  -v $PWD/changeset:/usr/src/myapp/changeset --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/dbpsql" -e "LIQUIBASE_USERNAME=dbpsql" -e "LIQUIBASE_PASSWORD=dbpsql"  skillbillsrl/liquibase update

## NOTES

### a psql server

> docker rm some-postgres

> docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres

### a psql client

> docker run -it --rm --link some-postgres:postgres postgres psql -h postgres -U postgres
