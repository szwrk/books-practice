# DBT - hr_dwh
MVP:
- dbt
- liquibase
- pyspark

## Transformations - DBT
**DB Credentials**
/home/arek/.dbt/profiles.yml
## Database Automations - Liquibse
liquibase update
## PySpark
spark-submit --jars ojdbc8.jar extract.py