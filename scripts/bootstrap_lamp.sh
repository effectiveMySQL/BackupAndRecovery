#/bin/sh


SCRIPT_NAME=`basename $0 | sed -e "s/.sh$//"`
[ -z "${TMP_DIR}" ] && TMP_DIR=/tmp
TMP_FILE="${TMP_DIR}/${SCRIPT_NAME}.tmp.$$"
MYSQL_PWD="passwd"

info() {
  echo `date +%Y%m%d.%H%M%S`" "$*
  return 0
}

cd $HOME
info "Configuring LAMP Server"
info "Detailed Log file can be found in ${TMP_FILE}"

# An assumption is made that MySQL is already installed.

info "Configuring Apache and dependencies"
sudo apt-get install -y lynx curl apache2 php5 php5-cgi php5-mcrypt libapache2-mod-php5 libapache2-mod-fcgid php5-mysql memcached php5-memcached >> ${TMP_FILE} 2>&1

echo "<?phpinfo()?>" > /tmp/p.php
sudo mv /tmp/p.php /var/www

# Tests have shown apache hangs, need restart for php anyway
sudo service apache2 restart
info "Confirming Apache"
curl http://localhost

info "Confirming PHP"
curl http://localhost/p.php

sudo sed -i "s/CustomLog/#CustomLog/" /etc/apache2/sites-available/default
sudo sed -i "s/CustomLog/#CustomLog/" /etc/apache2/conf.d/other-vhosts-access-log


exit 0
