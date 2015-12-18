## Installing beats

* [filebeat installation](https://www.elastic.co/guide/en/beats/filebeat/current/index.html)


### Installing Filebeat


*deb:*

```shell
  curl -L -O https://download.elastic.co/beats/filebeat/filebeat_{version}_amd64.deb
  sudo dpkg -i filebeat_{version}_amd64.deb
```

*rpm:*

```shell
  curl -L -O https://download.elastic.co/beats/filebeat/filebeat-{version}-x86_64.rpm
  sudo rpm -vi filebeat-{version}-x86_64.rpm
```


*mac:*

```shell
  curl -L -O https://download.elastic.co/beats/filebeat/filebeat-{version}-darwin.tgz
  tar xzvf filebeat-{version}-darwin.tgz
```

*win:*

. Download the Filebeat Windows zip file from the
https://www.elastic.co/downloads/beats/filebeat[downloads page].

. Extract the contents of the zip file into `C:\Program Files`.

. Rename the `filebeat-<version>-windows` directory to `Filebeat`.

. Open a PowerShell prompt as an Administrator (right-click the PowerShell icon and select *Run As Administrator*).

. Run the following commands to install Filebeat as a Windows service:

```
  > cd 'C:\Program Files\Filebeat'
  C:\Program Files\Filebeat> .\install-service-filebeat.ps1
```

Before starting Filebeat, you should look at the configuration options in the configuration
file, for example `C:\Program Files\Filebeat\filebeat.yml`. For more information about these options,
see <<filebeat-configuration-details>>.

### Configuring Filebeat

To configure Filebeat, you edit the _filebeat.yml_ file. Here is a sample of
the _filebeat.yml_ file:

```yaml
############################# Filebeat ######################################
filebeat:
  prospectors:
    -
      paths:
        - /var/log/*.log
      input_type: log
      ignore_older: 10m
      document_type: log
      scan_frequency: 10s
      harvester_buffer_size: 16384
      tail_files: true
      backoff: 1s
      max_backoff: 10s
      backoff_factor: 2
      partial_line_waiting: 5s
      force_close_windows_files: false

  spool_size: 1024
  idle_timeout: 5s
  registry_file: /var/lib/filebeat/registry
  config_dir:

############################# Output ##########################################
output:
  logstash:
    enabled: true
    hosts: ["10.168.153.51:5044"]
    loadbalance: true
    index: uat

############################# Shipper #########################################
shipper:
  name: uat-kcic

############################# Logging #########################################
logging:
  files:
    path: /var/log/mybeat
    name: mybeat
    rotateeverybytes: 10485760
    keepfiles: 7
```

### Loading the Index Template in Elasticsearch

Before starting Filebeat, you need to load the
http://www.elastic.co/guide/en/elasticsearch/reference/current/indices-templates.html[index
template], which lets Elasticsearch know which fields should be analyzed
in which way.

The recommended template file is installed by the Filebeat packages. Load it with the
following command:

*deb or rpm:*

```
  curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
```

*mac:*

```shell
  cd filebeat-{version}-darwin
  curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat.template.json
```

*win:*

```bat
  C:\Program Files\Filebeat> Invoke-WebRequest -Method Put -InFile filebeat.template.json -Uri http://localhost:9200/_template/filebeat?pretty
```

where `localhost:9200` is the IP and port where Elasticsearch is listening.


### Running Filebeat

Run Filebeat by issuing the appropriate command for your platform.

*deb:*

```shell
  sudo /etc/init.d/filebeat start
```

*rpm:*

```shell
  sudo /etc/init.d/filebeat start
```

*mac:*

```shell
  sudo ./filebeat -e -c filebeat.yml -d "publish"
```

*win:*

```bat
  C:\Program Files\Filebeat> Start-Service filebeat
```
By default, Windows log files are stored in `C:\ProgramData\filebeat\Logs`.

Filebeat is now ready to send log files to your defined output.

Enjoy!
