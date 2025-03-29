# DBT
## Tasks
 - [x] pipeline proof of concept (medalion)
 - [x] schema.yml with descriptions
 - [x] tests
 - [x] docs

## Screenshots
![Docs](assets/docs1.png)

![dbt run + model preview](assets/image.png)

## Cheatsheet
**Debug query**
cat target/run/hello/models/bronze/dbt_emp.sql

**Db config file**
~/.dbt/profiles.yml

**Win/Unix charset**
dos2unix models/bronze/dbt_emp.sql