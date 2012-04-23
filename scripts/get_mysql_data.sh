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
<<<<<<< HEAD
[ ! -f sakila-db.tar.gz ] && curl --silent -o sakila-db.sql.gz http://downloads.mysql.com/docs/sakila-db.tar.gz
echo ".. world - Employee"
[ ! -f employee.tar.bz2 ] && curl --silent -o employee.tar.bz2 https://launchpadlibrarian.net/24493789/employees_db-dump-files-1.0.5.tar.bz2
gunzip *.gz
tar xvfj *.bz2

=======
[ ! -f sakila-db.tar.gz ] && curl --silent -o sakila-db.tar.gz http://downloads.mysql.com/docs/sakila-db.tar.gz
echo ".. world - Employee"
[ ! -f employee.tar.bz2 ] && curl --silent -o employee.tar.bz2 https://launchpadlibrarian.net/24493789/employees_db-dump-files-1.0.5.tar.bz2
[ ! -f employee-code.tar.bz2 ] && curl -o employees-code.tar.bz2 https://launchpadlibrarian.net/24493350/employees_db-code-1.0.6.tar.bz2

tar xvfz *.tar.gz
gunzip *.gz
for file in `ls *.bz2`
do
 tar xvfj $file
done

mysqladmin create world_myisam
mysql world_myisam < world-myisam.sql
mysqladmin create world_innodb
mysql world_innodb < world-innodb.sql
cd sakila-db
mysql < sakila-schema.sql
mysql < sakila-data.sql

cd ..
cd employees_db
mysql < employees.sql
exit 0
>>>>>>> 4af18be9e3ccfd0a1520d1c2377c140ce810fa59
