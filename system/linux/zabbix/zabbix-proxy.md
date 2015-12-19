## Zabbix Proxy & Client

### Reference 
* [Zabbix official site](https://www.zabbix.com/documentation/3.0/manual)

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
	yum install glibc-devel.x86_64 -y -q 
	yum install curl-devel -y -q
	yum install wget.x86_64 -y -q
	yum install automake -y -q
	yum install sqlite.x86_64 -y -q
	yum install libidn-devel.x86_64 -y -q
	yum install libxml2-devel.x86_64 -y -q
	yum install openssl-devel.x86_64 -y -q
	yum install net-snmp-devel.x86_64 -y -q
	yum install rpm-devel.x86_64 -y -q
	yum install OpenIPMI-devel.x86_64 -y -q
	yum install iksemel-devel.x86_64 -y -q
	yum install libssh2-devel.x86_64 -y -q
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

### 安装zabbix proxy

* 下载zabbix 源码编译，如果不能下载则从zabbix官网下载3.0以上的版本

```shell
	wget http://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.3.0/zabbix-3.0.0.tar.gz
```

* 编译安装zabbix proxy

```
	tar zxvf zabbix-3.0.x
	cd zabbix-.3.0.x
	./configure  --prefix=/app/zabbix \
	--with-sqlite3 \
	--with-libcurl --with-net-snmp \
	--with-openipmi --with-ssh2 \
	--enable-proxy --with-openssl
	make 
	make install 
```

* 修改zabbix 配置文件

> vi /app/zabbix/etc/zabbix_proxy.conf
```shell
DBName=/data/zabbix/zabbix-proxy.db
```

* 修改启动脚本

```shell
	cp misc/init.d/fedora/core/zabbix_server /etc/init.d/zabbix_proxy
	chkconfig --add zabbix_proxy 
	chkconfig zabbix_proxy on 
```
> vi /etc/init.d/zabbix_proxy
```shell
	BASEDIR=/app/zabbix
```

### 安装Zabbix Client

*linux*

```shell
	tar zxf zabbix-3.0.x
	cd zabbix-3.0.x
	./configure  --prefix=/app/zabbix \
	--enable-agent --with-openssl
	make 
	make install 
```

```shell
	cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/zabbix_agentd
	chkconfig --add zabbix_agentd
	chkconfig zabbix_agentd on 
```
