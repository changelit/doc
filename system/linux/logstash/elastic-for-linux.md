=== Installing Elasticsearch

* [official document](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)

[[deb]]*deb:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo apt-get install openjdk-7-jre
curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-{ES-version}.deb
sudo dpkg -i elasticsearch-{ES-version}.deb
sudo /etc/init.d/elasticsearch start
----------------------------------------------------------------------

[[rpm]]*rpm:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo yum install java-1.7.0-openjdk
curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-{ES-version}.rpm
sudo rpm -i elasticsearch-{ES-version}.rpm
sudo service elasticsearch start
----------------------------------------------------------------------

[[mac]]*mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
# install Java, e.g. from: https://www.java.com/en/download/manual.jsp
curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-{ES-version}.zip
unzip elasticsearch-{ES-version}.zip
cd elasticsearch-{ES-version}
./bin/elasticsearch
----------------------------------------------------------------------

[[win]]*win:*

. If necessary, download and install the latest version of the Java from https://www.java.com[www.java.com].

. Download the Elasticsearch {ES-version} Windows zip file from the
https://www.elastic.co/downloads/elasticsearch[downloads page].

. Extract the contents of the zip file to a directory on your computer, for example, `C:\Program Files`.

. Open a command prompt as an Administrator and navigate to the directory that contains the extracted files, for example:
+
["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
cd C:\Program Files\elasticsearch-{ES-version}
----------------------------------------------------------------------

. Run the following command to start Elasticsearch:
+
["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
bin\elasticsearch.bat
----------------------------------------------------------------------

You can learn more about installing, configuring, and running Elasticsearch in the
https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html[Elasticsearch Reference].

==== Making Sure Elasticsearch is Up and Running


To test that the Elasticsearch daemon is up and running, try sending an HTTP GET
request on port 9200.

[source,shell]
----------------------------------------------------------------------
curl http://127.0.0.1:9200
----------------------------------------------------------------------

On Windows, if you don't have cURL installed, simply point your browser to the URL.

You should see a response similar to this:

[source,shell]
----------------------------------------------------------------------
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
