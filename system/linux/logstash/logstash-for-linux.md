## Installing Logstash

### Reference
* [How to install logstash on linux ](./logstash-for-linux.md)
* [How to install kibana on linux ](./kibana-for-linux.md)
* [How to install filebeat on linux ](./filebeat.md)
* [Logstash official document](https://www.elastic.co/guide/en/logstash/current/index.html)


### Prequisites
* Jdk version:1.75+

![Integration with Logstash](../images/beats-logstash.png)

*deb:*

```shell
  sudo apt-get install openjdk-7-jre
  curl -L -O https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.1.1-1_all.deb
  sudo dpkg -i logstash_2.1.1-1_all.deb
```

*rpm:*

```shell
  sudo yum install java-1.7.0-openjdk
  curl -L -O https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.1.1-1.noarch.rpm
  sudo rpm -i logstash-2.1.1-1.noarch.rpm
```

*mac:*

```shell
  # install Java, e.g. from: https://www.java.com/en/download/manual.jsp
  curl -L -O https://download.elastic.co/logstash/logstash/logstash-2.1.1.zip
  unzip logstash-2.1.1.zip
```

*win:*

. If necessary, download and install the latest version of the Java from https://www.java.com[www.java.com].

. Download the Logstash 2.1.1 Windows zip file from the
https://www.elastic.co/downloads/logstash[downloads page].

. Extract the contents of the zip file to a directory on your computer, for example, `C:\Program Files`.

Don't start Logstash yet. You need to set a couple of configuration options first.



### Setting Up Logstash


*deb, rpm, and mac:*

```shell
  ./bin/plugin install logstash-input-beats
```

*win:*

```bat
  bin\plugin install logstash-input-beats
```

Next configure Logstash to listen on port 5044 for incoming Beats connections
and to index into Elasticsearch. You configure Logstash by creating a
configuration file. For example, you can save the following example configuration
to a file called `config.json`:

```ruby
input {
  beats {
    port => 5044
  }
}

filter {
  if [file_type] == "json" {
        json {
                source => "message"
                target => "doc"
                remove_field => [ "line", "input_type","count","message","beat","type"]
             }
   }
}

output {
  elasticsearch {
    hosts => "localhost:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}
```

### Updating the Logstash Input Beats Plugin

*deb, rpm, and mac:*

```shell
  ./bin/plugin update logstash-input-beats
```

*win:*
```bat
  bin\plugin update logstash-input-beats
```


### Running Logstash

*deb:*

```shell
  sudo /etc/init.d/logstash start
```

*rpm:*

```shell
  sudo service logstash start
```

*mac:*

```shell
  ./bin/logstash -f config.json
```

*win:*

```bat
  bin\logstash.bat -f config.json
```

NOTE: The default configuration for Beats and Logstash uses plain TCP. For
encryption you must explicitly enable TLS when you configure Beats and Logstash.

