#!/bin/bash
#difine user varibles
_SOFT=ZABBIX
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/bin:/lib
_PACKAGE_URL="http://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.6/zabbix-2.4.6.tar.gz"
_BASENAME=$(basename $_PACKAGE_URL)
_SUFFIX=.tar.gz
_SOFTFNAME=$(echo $_BASENAME | sed -n "s/\(.*\)\($_SUFFIX\)/\1/p" )
_NEW_USER=zabbix
_NEW_GROUP=zabbix
_TMP_DIR=/tmp
_APP_DIR=/app
_LOGS_DIR=/logs
_DATA_DIR=/data


echo "-------  1,install packages which $_SOFT needs ... "
uname -a | grep i386									
if [ $? -eq 0 ]
 then
  version=i386
 else
  version=x86_64
fi
yum install cmake.$version -y -q							
yum install make.$version -y -q
yum install gcc.$version  -y -q 
yum install gcc-c++.$version -y -q
yum install zlib-devel.$version -y -q 
yum install mysql-devel.$version -y -q
yum install mysql.$version -y -q
yum install glibc-devel.$version -y -q 
yum install curl-devel -y -q
yum install wget.$version -y -q
yum install automake -y -q
yum install libidn-devel.$version -y -q
yum install libxml2-devel.$version -y -q
yum install openssl-devel.$version -y -q
yum install net-snmp-devel.$version -y -q
yum install rpm-devel.$version -y -q
yum install OpenIPMI-devel.$version -y -q
yum install iksemel-devel.$version -y -q
yum install libssh2-devel.$version -y -q
yum install openldap-devel.$version -y -q



echo "-------  2,download $_SOFT ... "								
wget --directory-prefix=$_TMP_DIR $_PACKAGE_URL

echo "-------  3,Create $_SOFT user and related groups"
id $_NEW_USER 2>/dev/nul
if test $? != 0 ;then
{
	groupadd $_NEW_GROUP
	useradd -M -s /sbin/nologin --gid $_NEW_GROUP $_NEW_USER
}
else
{
	echo "ERROR. $_NEW_USER is exists,please check it" 
}
fi 


echo "-------  4,Create $_SOFT data and app directory "
mkdir -p $_APP_DIR/$_NEW_USER 
mkdir -p $_LOGS_DIR/$_NEW_USER
mkdir -p $_DATA_DIR/$_NEW_USER

echo "-------  5,Installing $_SOFT software,please waiting ..."
cd $_TMP_DIR
tar zxf $_BASENAME
cd $_SOFTFNAME
./configure  --prefix=/app/zabbix \
--enable-server --with-mysql \
--with-libcurl --with-net-snmp \
--with-openipmi --with-ssh2 \
--with-ldap --enable-agent --enable-proxy
make 
make install 
echo "-------  6,Installation have been completed"

echo "-------  7,Change directory owner to $_SOFT user"
chown -R $_NEW_USER:$_NEW_GROUP $_APP_DIR/$_NEW_USER
chown -R $_NEW_USER:$_NEW_GROUP $_LOGS_DIR/$_NEW_USER
chown -R $_NEW_USER:$_NEW_GROUP $_DATA_DIR/$_NEW_USER


echo "-------  8,SOFTWARE Specific Configuration "
chmod 400 $_APP_DIR/$_NEW_USER/etc/zabbix_server.conf

#make MYSQL IP and password 
echo -n "please input MYSQL server IP:"
while read passwd1
do
  echo -e '\r'
  
  if [  "$passwd1" = '' ]
   then 
        echo -n "please input one word at least:"
   else
	echo -e "input again:\c"
	read passwd2
	if [ "$passwd1" = "$passwd2" ];then 
		break;
	else 
		echo -e "\r"
		echo -e "twice input are not the same !\c"
		echo -e "\r"
		echo -e "please input all sys passwd:\c"
		passwd1=''
		passwd2=''
        fi 
  fi
done

echo -n "please input MYSQL server passwd:"
while read passwdd1
do
  echo -e '\r'
  
  if [  "$passwdd1" = '' ]
   then 
        echo -n "please input one word at least:"
   else
	echo -e "input again:\c"
	read passwdd2
	if [ "$passwdd1" = "$passwdd2" ];then 
		break;
	else 
		echo -e "\r"
		echo -e "twice input are not the same !\c"
		echo -e "\r"
		echo -e "please input all sys passwd:\c"
		passwdd1=''
		passwdd2=''
        fi 
  fi
done

_MYSQL_IP=$passwd1
_MYSQL_PWD=$passwdd1

#import data into MYSQL database
mysql -h $_MYSQL_IP -uzabbix --password=$_MYSQL_PWD zabbix<database/mysql/schema.sql 
mysql -h $_MYSQL_IP -uzabbix --password=$_MYSQL_PWD zabbix<database/mysql/images.sql 
mysql -h $_MYSQL_IP -uzabbix --password=$_MYSQL_PWD zabbix<database/mysql/data.sql 
 
#replace configuration file  
FILEPATH=$_APP_DIR/$_NEW_USER/etc/zabbix_server.conf
if test ! -f $FILEPATH ;then
{
	echo 'ssh configuration file does not exists,please check it'
	exit 2 
}
fi
DELIM='='
_TMPFILE=F$RANDOM
cat >>$_TMP_DIR/$_TMPFILE <<EOF
#DBName#zabbix#EOF#
#DBUser#zabbix#EOF#
#DBPassword#$_MYSQL_PWD#EOF#
#DBHost#$_MYSQL_IP#EOF#
EOF

i=1
for j in `grep "#$" $_TMP_DIR/$_TMPFILE | sed 's/#/  /g'`
do
	v=`expr $i % 3`
	if test ! -n $j  ; then
	break;
	elif test $v -eq 0 ;then 
		PARA1=$j
		linenum=$(grep -nw "^$PARA2" $FILEPATH | awk -F : '{printf $1}')
		if test -z $linenum ;then
		{	
			if test $PARA1 = EOF ;then
			{
				echo "$PARA2$DELIM$PARA3" >>$FILEPATH
				
			}
			else
			{
				linenum=$(grep -nF "$PARA1" $FILEPATH | awk -F : '{printf $1}')
				linenum=$((linenum+1))
				sed -i "$linenum i $PARA2$DELIM$PARA3" $FILEPATH 
			}
			fi
		}
		else
		{
			sed -i "$linenum d" $FILEPATH 
			sed -i "$linenum i $PARA2$DELIM$PARA3" $FILEPATH
		}
		fi
		
	elif test $v -eq 1 ;then
		PARA2=$j

	else test $v -eq 2 
		PARA3=$j
	fi	
	i=$((i+1))
done 
#delete temp file 
rm -f $_TMP_DIR/$_TMPFILE

#make zabbix server start when system startup
cd $_TMP_DIR/$_SOFTFNAME
cp misc/init.d/fedora/core/zabbix_server /etc/init.d/zabbix_server
cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/zabbix_agentd

chkconfig --add zabbix_server 
chkconfig --add zabbix_agentd 
chkconfig zabbix_server on 
chkconfig zabbix_agentd on 












