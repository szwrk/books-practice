# DBT - hr_dwh
MVP:
- duckdb (eda)
- dbt
- liquibase
- pyspark

## Flow
```mermaid
graph TD
    /data <--> |extract employees.csv|spark
    /data <--> |extract departments.csv| dbt-seed
    spark --> |load| dwh1
    dbt-seed --> |load| dwh1
    liquibase --> |setup schema|dwh1
```

## Transformations - DBT
**DB Credentials**
/home/arek/.dbt/profiles.yml
**Commands**
dbt ls --resource-type seed


## Database Automations - Liquibse
liquibase update

## Spark
spark-submit --jars ojdbc8.jar extract.py