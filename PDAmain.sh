#!/bin/bash

##################################################################
#Script Name: PDAmain.sh
#Description: Total Automation of all the tasks
#Name: Yash Balaji Iyengar
#SID: x18124739
###################################################################

WORK_DIR = '/home/hduser/project'

# Loading Data to MySql 
mysql --user="yash" --database="cars" --password="yash" < ${WORK_DIR}/mysql/pda_mysql.sql

# Data loading from MySql to Hadoop

hadoop dfs -rm -R /PDA/cars

# MySql to Hadoop load with sqoop
sqoop import --connect jdbc:mysql://127.0.0.1/cars --username yash --password yash --table cars -m 1 --target-dir /PDA/cars

hadoop dfs -rm -R /PDA/cars/_SUCCESS

# Pig Execution Jobs

hdfs dfs -rm -R /PDA/pig/pigq1_grp
hdfs dfs -rm -R /PDA/pig/pigq2_grp


# Executing Pig Queries on Distributed mode

pig -x mapreduce ${WORK_DIR}/pig/pig_grp.pig

# Transfering Pig output from HDFS to NoSQL database (HBase)
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator="," -Dimporttsv.columns=HBASE_ROW_KEY,colfam2 pigq1_grp hdfs://localhost:54310/PDA/pig/pigq1_grp/part-r-00000

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator="," -Dimporttsv.columns=HBASE_ROW_KEY,colfam2 pigq2_grp hdfs://localhost:54310/PDA/pig/pigq2_grp/part-r-00000

#dropping existing hive table
hdfs dfs -rm -R /user/hive/warehouse/cars
hive
DROP TABLE
exit;

# loading data from mysql to hive using sqoop

sqoop import --connect jdbc:mysql://127.0.0.1/cars --username yash --password yash --table cars -m 1 --hive-import --create-hive-table --hive-table cars

# Running hive query and storing results on Hadoop

hive -f ${WORK_DIR}/hive/hive_query.hql
