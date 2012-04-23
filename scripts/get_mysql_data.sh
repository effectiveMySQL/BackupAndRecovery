#!/bin/sh
cd ..
mkdir -p data
cd data

#
# Sample MySQL databases from http://dev.mysql.com/doc/index-other.html
#
echo "MySQL Example Databases"
echo ".. world - InnoDB"
[ ! -f world-innodb.sql.gz ] && curl --silent -o world-innodb.sql.gz http://downloads.mysql.com/docs/world_innodb.sql.gz
echo ".. world - MyISAM"
[ ! -f world-myisam.sql.gz ] && curl --silent -o world-myisam.sql.gz http://downloads.mysql.com/docs/world.sql.gz
echo ".. world - Sakila"
[ ! -f sakila-db.tar.gz ] && curl --silent -o sakila-db.sql.gz http://downloads.mysql.com/docs/sakila-db.tar.gz
echo ".. world - Employee"
[ ! -f employee.tar.bz2 ] && curl --silent -o employee.tar.bz2 https://launchpadlibrarian.net/24493789/employees_db-dump-files-1.0.5.tar.bz2
gunzip *.gz
tar xvfj *.bz2

