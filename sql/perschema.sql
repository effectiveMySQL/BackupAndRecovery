################################################################################
# Name     :  perschema.sql
# Purpose  :  List details of the specific schema
# Author   :  Ronald Bradford  http://ronaldbradford.com
################################################################################

SELECT   NOW(), VERSION();

# Per Schema Queries
SET @schema = IFNULL(@schema,DATABASE());

# One Line Schema Summary
SELECT   table_schema,
         SUM(data_length+index_length)/1024/1024 AS total_mb,
         SUM(data_length)/1024/1024 AS data_mb,
         SUM(index_length)/1024/1024 AS index_mb,
         COUNT(*) AS tables,
         CURDATE() AS today
FROM     information_schema.tables
WHERE    table_schema=@schema
GROUP BY table_schema;

# Schema Table Usage
SELECT   if(length(table_name)>20,concat(left(table_name,18),'..'),table_name) AS table_name,
         engine,row_format as format, table_rows, avg_row_length as avg_row,
         round((data_length+index_length)/1024/1024,2) as total_mb, 
         round((data_length)/1024/1024,2) as data_mb, 
         round((index_length)/1024/1024,2) as index_mb
FROM     information_schema.tables 
WHERE    table_schema=@schema
ORDER BY 6 DESC;
