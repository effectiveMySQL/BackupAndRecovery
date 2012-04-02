#!/bin/sh
cd ..
mkdir -p data
cd data

#
# Sample MySQL databases from http://dev.mysql.com/doc/index-other.html
#
echo "MySQL Example Databases"
echo ".. world - InnoDB"
curl --silent -o world-innodb.sql.gz http://downloads.mysql.com/docs/world_innodb.sql.gz
echo ".. world - MyISAM"
curl --silent -o world-myisam.gz http://downloads.mysql.com/docs/world.sql.gz
echo ".. world - Sakila"
curl --silent -o sakila-db.sql.gz http://downloads.mysql.com/docs/sakila-db.tar.gz
echo ".. world - Employee"
curl --silent -o employee.tar.bz2 https://launchpadlibrarian.net/24493789/employees_db-dump-files-1.0.5.tar.bz2
