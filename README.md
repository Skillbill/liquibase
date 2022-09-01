## build
> docker build -t skillbillsrl/liquibase .

it create an image called skillbillsrl/liquibase


## USE THIS IMAGE

Precondition is that there is another docker image running postgres named some-postgres.

### single file

put all the changeset into the file liquibase.yml and run

> docker run  -v `pwd`:/drivers  -v $PWD/liquibase.yml:/usr/src/myapp/liquibase.yml  --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/dbpsql" -e "LIQUIBASE_USERNAME=dbpsql" -e "LIQUIBASE_PASSWORD=dbpsql"  skillbillsrl/liquibase  update


### multi files

put all the changeset into the folder changeset. The root file is liquibase.yml.
The root file can contain one or more changeset (as for the single file version) or the include directive to include how many file you want.
The run.

> docker run -v $PWD:/drivers  -v $PWD/changeset:/usr/src/myapp/changeset --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/dbpsql" -e "LIQUIBASE_USERNAME=dbpsql" -e "LIQUIBASE_PASSWORD=dbpsql"  skillbillsrl/liquibase:multifiles update

## NOTES

### Fix checksum

Sometime it happens that the checksum change. Can be that there was a change on liquibase version or a change in a development changeset.
In this case liquibase fails with an error like:

> Unexpected error running Liquibase: Validation Failed:

If you are sure that cause was a change or liquibase version or a development changeset, you can reset the checksum with the command:

> docker run  -v $PWD:/drivers --link some-postgres:postgres -e "LIQUIBASE_URL=jdbc:postgresql://postgres/dbpsql" -e "LIQUIBASE_USERNAME=dbpsql" -e "LIQUIBASE_PASSWORD=dbpsql"  skillbillsrl/liquibase  clearChecksums

Then you can apply again your changes.



### a psql server

> docker rm some-postgres

> docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres

### a psql client

> docker run -it --rm --link some-postgres:postgres postgres psql -h postgres -U postgres
