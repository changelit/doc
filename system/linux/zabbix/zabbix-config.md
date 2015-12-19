*zabbix-proxy*

```shell
ProxyMode=0
Server=127.0.0.1
ServerPort=10051
Hostname={{ proxy_name }}
ListenIP={{ server_ip }}
ListenPort=10051
HousekeepingFrequency=1
DBName=/data/zabbix/zabbix-proxy.db
LogFile=/logs/zabbix/zabbix_proxy.log
LogFileSize=3
PidFile=/logs/zabbix/zabbix_proxy.pid
StartTrappers=10
StartPollers=10
CacheSize=8M
Timeout=10
UnreachablePeriod=45
UnavailableDelay=60
UnreachableDelay=15
TmpDir=/tmp
AllowRoot=0
User=zabbix

HeartbeatFrequency=60
ConfigFrequency=3600
DataSenderFrequency=5

# DebugLevel=3
# SourceIP=
# ProxyLocalBuffer=0
# ProxyOfflineBuffer=1
# StartIPMIPollers=0
# StartPollersUnreachable=1
# StartPingers=1
# StartDiscoverers=1
# StartHTTPPollers=1
# JavaGateway=
# JavaGatewayPort=10052
# StartJavaPollers=0
# StartVMwareCollectors=0
# VMwareFrequency=60
# VMwarePerfFrequency=60
# VMwareCacheSize=8M
# VMwareTimeout=10
# SNMPTrapperFile=/tmp/zabbix_traps.tmp
# StartSNMPTrapper=0
# StartDBSyncers=4
# HistoryCacheSize=8M
# HistoryTextCacheSize=16M
# TrapperTimeout=300
# ExternalScripts=${datadir}/zabbix/externalscripts
# FpingLocation=/usr/sbin/fping
# Fping6Location=/usr/sbin/fping6
# LogSlowQueries=0
# Include=
# SSLCertLocation=${datadir}/zabbix/ssl/certs
# SSLKeyLocation=${datadir}/zabbix/ssl/keys
# SSLCALocation=
# LoadModulePath=${libdir}/modules
# LoadModule=
```

*zabbix-server*

```shell
ListenPort=10051
ListenIP=127.0.0.1
LogFile=/logs/zabbix/zabbix_server.log
LogFileSize=10
PidFile=/logs/zabbix/zabbix_server.pid
TmpDir=/tmp
#StartProxyPollers=3
#ProxyConfigFrequency=3600
#ProxyDataFrequency=10
AllowRoot=0
User=zabbix
DBPassword=zabbix
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPort=3306
DBSocket=/app/mysql/mysql.sock

StartTrappers=5
StartPollers=5
CacheSize=16M
Timeout=10

# SourceIP=
# StartIPMIPollers=0
# StartPollersUnreachable=1
# StartPingers=1
# StartDiscoverers=1
# StartHTTPPollers=1
# StartTimers=1
# JavaGatewayPort=10052
# StartJavaPollers=0
# StartVMwareCollectors=0
# VMwareFrequency=60
# VMwarePerfFrequency=60
# VMwareCacheSize=8M
# VMwareTimeout=10
# SNMPTrapperFile=/tmp/zabbix_traps.tmp
# StartSNMPTrapper=0
# HousekeepingFrequency=1
# MaxHousekeeperDelete=500
# SenderFrequency=30
# CacheUpdateFrequency=60
# StartDBSyncers=4
# HistoryCacheSize=8M
# TrendCacheSize=4M
# HistoryTextCacheSize=16M
# ValueCacheSize=8M
# TrapperTimeout=300
# UnreachablePeriod=45
# UnavailableDelay=60
# UnreachableDelay=15
AlertScriptsPath=/app/zabbix/alertscripts
# ExternalScripts=${datadir}/zabbix/externalscripts
# FpingLocation=/usr/sbin/fping
# Fping6Location=/usr/sbin/fping6
# SSHKeyLocation=
# LogSlowQueries=0
# Include=
# SSLCertLocation=${datadir}/zabbix/ssl/certs
# SSLKeyLocation=${datadir}/zabbix/ssl/keys
# SSLCALocation=
```

*zabbix-agent*

```shell
PidFile=/logs/zabbix/zabbix_agentd.pid
LogFile=/logs/zabbix/zabbix_agentd.log
LogFileSize=1
# DebugLevel=3
# SourceIP=
# EnableRemoteCommands=0
# LogRemoteCommands=0

Server=127.0.0.1
ListenPort=10050
# ListenIP=0.0.0.0
StartAgents=3
ServerActive=127.0.0.1
Hostname=Zabbix Server
RefreshActiveChecks=60
BufferSend=5
BufferSize=100
MaxLinesPerSecond=100
Timeout=5
AllowRoot=1
User=zabbix

UnsafeUserParameters=1
Include=/app/zabbix/etc/zabbix_agentd.conf.d/*.conf
TLSConnect=psk
TLSAccept=psk
TLSPSKFile=/app/zabbix/etc/zabbix_agentd.psk
TLSPSKIdentity=Zabbix Server
```