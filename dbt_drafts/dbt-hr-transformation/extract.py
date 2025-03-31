from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("hrdwh") \
    .config("spark.jars", "ojdbc8.jar") \
    .getOrCreate()

jdbc_url = "jdbc:oracle:thin:@//srv2.lan:1521/free"
connection_props = {
    "user": "hr_dwh",
    "password": "oracle",
    "driver": "oracle.jdbc.driver.OracleDriver"
}

dfhr = spark.read.csv("emp.csv", header=True, inferSchema=True)
dfhr.write.jdbc(
    url=jdbc_url,
    table="EMPLOYEES_RAW",
    mode="append",
    properties=connection_props
)
 