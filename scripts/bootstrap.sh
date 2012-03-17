#!/bin/sh
#
# bootstrap.sh - Configures a virgin Ubuntu server for Default LAMP Operations
#
SCRIPT_NAME=`basename $0 | sed -e "s/.sh$//"`
[ -z "${TMP_DIR}" ] && TMP_DIR=/tmp
TMP_FILE="${TMP_DIR}/${SCRIPT_NAME}.tmp.$$"
MYSQL_PWD="passwd"

info() {
  echo `date +%Y%m%d.%H%M%S`" "$*
  return 0
}

info "Configuring new Ubuntu Environment"
info "Detailed Log file can be found in ${TMP_FILE}"
info "Upgrading Distribution"
sudo apt-get update  >> ${TMP_FILE} 2>&1
sudo apt-get -y upgrade >> ${TMP_FILE} 2>&1
sudo apt-get install -qq debconf-utils >> ${TMP_FILE} 2>&1
info "Installing MySQL"
info ".. Precreating MySQL password prompts"
cat << EOF | sudo debconf-set-selections
mysql-server-5.1 mysql-server/root_password password ${MYSQL_PWD}
mysql-server-5.1 mysql-server/root_password_again password ${MYSQL_PWD}
mysql-server-5.1 mysql-server/root_password seen true
mysql-server-5.1 mysql-server/root_password_again seen true
EOF
sudo apt-get install -qq mysql-server mysql-client >> ${TMP_FILE} 2>&1
info "Confirming MySQL"
info ".. Installed Packages"
sudo dpkg -l | grep mysql
info ".. Running Version"
mysql -uroot -p${MYSQL_PWD} -e "SELECT VERSION()" | tail -1

exit 99

sudo service mysql stop
# get my.cnf
sudo cp /tmp/my.cnf /etc/mysql
sudo rm -f /var/lib/mysql/ib_logfile0 /var/lib/mysql/ib_logfile1
sudo service mysql start
sudo ls -lh /var/lib/mysql
sudo tail -20 /var/log/mysql/error.log

exit 0
