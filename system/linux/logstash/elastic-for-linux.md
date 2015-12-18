## Installing Elasticsearch

### Reference
* [Elasticsearch official document](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
* [How to install logstash on linux ](./logstash-for-linux.md)
* [How to install kibana on linux ](./kibana-for-linux.md)
* [How to install filebeat on linux ](./filebeat.md)

### Prequisites
* Jdk version:1.75+

### Install Elasticsearch 
*deb:*

```shell
  sudo apt-get install openjdk-7-jre
  curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-2.1.1.deb
  sudo dpkg -i elasticsearch-2.1.1.deb
  sudo /etc/init.d/elasticsearch start
```

*rpm:*

```shell
  sudo yum install java-1.7.0-openjdk
  curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-2.1.1.rpm
  sudo rpm -i elasticsearch-2.1.1.rpm
  sudo service elasticsearch start
```

*mac:*

```shell
  # install Java, e.g. from: https://www.java.com/en/download/manual.jsp
  curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-2.1.1.zip
  unzip elasticsearch-2.1.1.zip
  cd elasticsearch-2.1.1
  ./bin/elasticsearch
```
*win:*

https://www.elastic.co/downloads/elasticsearch [downloads page].

. Extract the contents of the zip file to a directory on your computer, for example, `C:\Program Files`.

. Open a command prompt as an Administrator and navigate to the directory that contains the extracted files, for example:
```bat
  cd C:\Program Files\elasticsearch-2.1.1
```
. Run the following command to start Elasticsearch:
```bat
  bin\elasticsearch.bat
```

### Making Sure Elasticsearch is Up and Running

To test that the Elasticsearch daemon is up and running, try sending an HTTP GET
request on port 9200.

```shell
  curl http://127.0.0.1:9200
```
On Windows, if you don't have cURL installed, simply point your browser to the URL.

You should see a response similar to this:
```yaml
{
  "name" : "Banshee",
  "cluster_name" : "elasticsearch",
  "version" : {
    "number" : "2.1.0",
    "build_hash" : "72cd1f1a3eee09505e036106146dc1949dc5dc87",
    "build_timestamp" : "2015-11-18T22:40:03Z",
    "build_snapshot" : false,
    "lucene_version" : "5.3.1"
  },
  "tagline" : "You Know, for Search"
}
```