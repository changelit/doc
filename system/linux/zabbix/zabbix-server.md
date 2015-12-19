## Zabbix Server

### Reference 
* [Zabbix official site](https://www.zabbix.com/documentation/3.0/manual)
* [Auto install script](zabbix_server.sh)

![zabbix](../images/zabbix-flow.jpg)
### 环境需求

* System: Centos 6.x x86_64
* Zabbix: 3.0.0 + 

* Package dependencies 

```shell
	yum install cmake.x86_64 -y -q							
	yum install make.x86_64 -y -q
	yum install gcc.x86_64  -y -q 
	yum install gcc-c++.x86_64 -y -q
	yum install zlib-devel.x86_64 -y -q 
	yum install mysql-devel.x86_64 -y -q
	yum install mysql.x86_64 -y -q
	yum install mysql-server.x86_64 -y -q
	yum install glibc-devel.x86_64 -y -q 
	yum install curl-devel -y -q
	yum install wget.x86_64 -y -q
	yum install automake -y -q
	yum install libidn-devel.x86_64 -y -q
	yum install libxml2-devel.x86_64 -y -q
	yum install openssl-devel.x86_64 -y -q
	yum install net-snmp-devel.x86_64 -y -q
	yum install rpm-devel.x86_64 -y -q
	yum install OpenIPMI-devel.x86_64 -y -q
	yum install iksemel-devel.x86_64 -y -q
	yum install libssh2-devel.x86_64 -y -q
	yum install openldap-devel.x86_64 -y -q
```

### 标准用户目录结构

* 创建运行用户与目录
```
	useradd -M -s /sbin/nologin zabbix
	mkdir -p /app/zabbix
	mkdir -p /data/zabbix
	mkdir -p /logs/zabbix
	chown -R zabbix:zabbix /logs/zabbix
```

### 安装zabbix server

* 下载zabbix 源码编译，如果不能下载则从zabbix官网下载3.0以上的版本

```shell
	wget http://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.3.0/zabbix-3.0.0.tar.gz
```

* 配置mysql 数据库

```shell
	tar zxvf zabbix-3.0.x
	cd zabbix-3.0.x
	mysql -uroot -p

	>create database zabbix;
	>grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';
	>flush privileges;
	>quit;

	mysql -uroot zabbix<database/mysql/schema.sql
	mysql -uroot zabbix<database/mysql/images.sql
	mysql -uroot zabbix<database/mysql/data.sql
```

* 编译安装zabbix server

```
	./configure  --prefix=/app/zabbix \
	--enable-server --with-mysql \
	--with-libcurl --with-net-snmp \
	--with-openipmi --with-ssh2 \
	--with-ldap --enable-agent --with-openssl
	make 
	make install 
```

* 修改zabbix 配置文件
> vi /app/zabbix/etc/zabbix_server.conf
```shell
	DBName=zabbix
	DBUser=zabbix
	DBPassword=zabbix
```

* 修改启动脚本

```shell
	cp misc/init.d/fedora/core/zabbix_server /etc/init.d/zabbix_server
	cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/zabbix_agentd
	chkconfig --add zabbix_server 
	chkconfig --add zabbix_agentd 
	chkconfig zabbix_server on 
	chkconfig zabbix_agentd on 
```
> vi /etc/init.d/zabbix_server
```shell
	BASEDIR=/app/zabbix
```

### 安装web前端

* 安装依赖包

```shell 
	yum install -y httpd php-gd php-devel gd gd-devel php php-xml php-bcmath php-mysql php-mbstring  curl curl-devel net-snmp libxml2 libxml2-devel
```

* 修改php配置文件

> vi /etc/php.ini
```shell
max_input_time = 600
max_execution_time = 300
date.timezone = Asia/Shanghai
post_max_size = 32M
memory_limit = 128M
```

**NOTICE**: 如果mysql是编译安装的，并且更改了默认目录，则需要修改php.ini的配置(两处):`mysqli.default_socket = /app/mysql/mysql.sock`

* 复制zabbix网络页面到http默认目录

```shell
	cp -r frontends/php/* /var/www/html
```

* 启动http，zabbix服务

```shell
	service httpd start
	service zabbix_server start
```