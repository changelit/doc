[[logstash-installation]]
=== Installing Logstash

* [official document](https://www.elastic.co/guide/en/logstash/current/index.html)

image:./images/beats-logstash.png[Integration with Logstash]

To download and install Logstash, use the commands that work
with your system:

*deb:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo apt-get install openjdk-7-jre
curl -L -O https://download.elastic.co/logstash/logstash/packages/debian/logstash_{LS-version}-1_all.deb
sudo dpkg -i logstash_{LS-version}-1_all.deb
----------------------------------------------------------------------

*rpm:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo yum install java-1.7.0-openjdk
curl -L -O https://download.elastic.co/logstash/logstash/packages/centos/logstash-{LS-version}-1.noarch.rpm
sudo rpm -i logstash-{LS-version}-1.noarch.rpm
----------------------------------------------------------------------

*mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
# install Java, e.g. from: https://www.java.com/en/download/manual.jsp
curl -L -O https://download.elastic.co/logstash/logstash/logstash-{LS-version}.zip
unzip logstash-{LS-version}.zip
----------------------------------------------------------------------

*win:*

. If necessary, download and install the latest version of the Java from https://www.java.com[www.java.com].

. Download the Logstash {LS-version} Windows zip file from the
https://www.elastic.co/downloads/logstash[downloads page].

. Extract the contents of the zip file to a directory on your computer, for example, `C:\Program Files`.

Don't start Logstash yet. You need to set a couple of configuration options first.

[[logstash-setup]]
==== Setting Up Logstash

In this setup, the Beat sends events to Logstash. Logstash receives
these events by using the
https://www.elastic.co/guide/en/logstash/current/plugins-inputs-beats.html[Logstash Input Beats
plugin] and then sends the transaction to Elasticsearch by using the
http://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html[Elasticsearch
output plugin]. The Elasticsearch plugin of Logstash uses the bulk API, making
indexing very efficient.

The minimum required Logstash version for this plugin is 1.5.4. If you are using
Logstash 1.5.4, you must install the Beats input plugin before applying this
configuration because the plugin is not shipped with 1.5.4. To install
the required plugin, run the following command inside the logstash directory
(for deb and rpm installs, the directory is `/opt/logstash`).

*deb, rpm, and mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
./bin/plugin install logstash-input-beats
----------------------------------------------------------------------

*win:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
bin\plugin install logstash-input-beats
----------------------------------------------------------------------

Next configure Logstash to listen on port 5044 for incoming Beats connections
and to index into Elasticsearch. You configure Logstash by creating a
configuration file. For example, you can save the following example configuration
to a file called `config.json`:

[source,ruby]
------------------------------------------------------------------------------
input {
  beats {
    port => 5044
  }
}

output {
  elasticsearch {
    hosts => "localhost:9200"
    sniffing => true
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}
------------------------------------------------------------------------------

Logstash uses this configuration to index events in Elasticsearch in the same
way that the Beat would, but you get additional buffering and other capabilities
provided by Logstash.

To use this setup, you'll also need to configure your Beat to use Logstash. For more information, see the documentation for your Beat.

[[logstash-input-update]]
==== Updating the Logstash Input Beats Plugin

If you are running Logstash 2.0 or earlier, you might not have the latest
version of the https://www.elastic.co/guide/en/logstash/current/plugins-inputs-beats.html[Logstash Input Beats plugin].
You can easily update to the latest
version of the input plugin from your Logstash installation:

*deb, rpm, and mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
./bin/plugin update logstash-input-beats
----------------------------------------------------------------------

*win:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
bin\plugin update logstash-input-beats
----------------------------------------------------------------------

More details about working with input plugins in Logstash are available https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html[here].


==== Running Logstash

Now you can start Logstash. Use the command that works with your system. If you
installed Logstash as a deb or rpm package, make sure the config file is in the
expected directory.

*deb:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo /etc/init.d/logstash start
----------------------------------------------------------------------

*rpm:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
sudo service logstash start
----------------------------------------------------------------------

*mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
./bin/logstash -f config.json
----------------------------------------------------------------------

*win:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
bin\logstash.bat -f config.json
----------------------------------------------------------------------

NOTE: The default configuration for Beats and Logstash uses plain TCP. For
encryption you must explicitly enable TLS when you configure Beats and Logstash.

You can learn more about installing, configuring, and running Logstash
https://www.elastic.co/guide/en/logstash/current/getting-started-with-logstash.html[here].

