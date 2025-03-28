@echo off
set JAVA_HOME=C:\java\openjdk11.0.2
set PATH=%JAVA_HOME%\bin;%PATH%
set PATH=%JAVA_HOME%\bin;%HADOOP_HOME%\bin;%PATH%
set SPARK_HOME=C:\spark
set PATH=%SPARK_HOME%\bin;%PATH%
call activate pyspark-r
call "C:\Program Files\VSCodium\VSCodium.exe" .

cmd