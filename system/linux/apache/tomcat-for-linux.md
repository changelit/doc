# Tomcat Installation

## Software and Environment Requirements
* System: Centos 6.x or Ubuntu 14.04 
* JDK: 1.8.0_65
* Tomcat: 8.0.30

## Uniform system environment
* create tomcat user

    	sudo useradd -M -s /usr/sbin/nologin tomcat
    	
* create uniform directory for tomcat

    	sudo mkdir -p /app
    	sudo mkdir -p /logs/tomcat
    	sudo mkdir -p /data/tomcat-tbs
    	sudo chown -R tomcat:tomcat /logs/tomcat
    	

## Upload software to server 
* Download jdk and tomcat to Server,it locates at  
``` 
    NAS:/kacha/Software/Linux/apache-tomcat-8.0.30.tar.gz 
    NAS:/kacha/Software/Linux/jdk-8u65-linux-x64.tar.gz
```



## Install JDK to server
* Setup JDK directory
```
	tar zxvf jdk-8u65-linux-x64.tar.gz
	sudo mv jdk-8u65-linux-x64 /app/jdk1.8.0_65
```
* Setup java environment PATH,add new line in  /etc/profile
```
	export PATH=$PATH:/app/jdk1.8.0_65/bin
```

## Install Tomcat to Server
* Setup Tomcat directory
```
	tar zxvf apache-tomcat-8.0.30.tar.gz
	sudo mv apache-tomcat-8.0.30 /app/tomcat-tbs
	sudo chown -R tomcat:tomcat /app/tomcat-tbs
```
* Copy server.xml to configuation directory,\[ Click to download [server.xml](server.xml) \]
```
	sudo cp server.xml /app/tomcat-tbs/conf/server.xml
```
* Modify catalina.sh in configuation directory ,insert two new line on the Second Line
```
	JAVA_HOME=/app/jdk1.8.0_65
	JAVA_OPTS="-server -Xms512m -Xmx2048m "
```
* Make tomcat startup when the system booted up,\[ Click to download [boot scripts](tomcat-tbs)\]
```
	sudo cp tomcat-tbs /etc/init.d/tomcat-tbs
	sudo chmod 755 /etc/init.d/tomcat-tbs
	sudo sysv-rc-conf tomcat-tbs on
```
