
[[kibana-installation]]
=== Installing Kibana

* [official document](https://www.elastic.co/guide/en/kibana/current/index.html)

*deb or rpm:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
curl -L -O https://download.elastic.co/kibana/kibana/kibana-{Kibana-version}-linux-x64.tar.gz
tar xzvf kibana-{Kibana-version}-linux-x64.tar.gz
cd kibana-{Kibana-version}-linux-x64/
./bin/kibana
----------------------------------------------------------------------

*mac:*

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
curl -L -O https://download.elastic.co/kibana/kibana/kibana-{Kibana-version}-darwin-x64.tar.gz
tar xzvf kibana-{Kibana-version}-darwin-x64.tar.gz
cd kibana-{Kibana-version}-darwin-x64/
./bin/kibana
----------------------------------------------------------------------

*win:*

. Download the Kibana {Kibana-version} Windows zip file from the
https://www.elastic.co/downloads/kibana[downloads page].

. Extract the contents of the zip file to a directory on your computer, for example, `C:\Program Files`.

. Open a command prompt as an Administrator and navigate to the directory that
contains the extracted files, for example:
+
["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
cd C:\Program Files\kibana-{Kibana-version}-windows
----------------------------------------------------------------------

. Run the following command to start Kibana:
+
["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
bin\kibana.bat
----------------------------------------------------------------------

You can find Kibana binaries for other operating systems on the
https://www.elastic.co/downloads/kibana[Kibana downloads page].

==== Launching the Kibana Web Interface

To launch the Kibana web interface, point your browser to port 5601. For example, `http://127.0.0.1:5601`.

You can learn more about Kibana in the
http://www.elastic.co/guide/en/kibana/current/index.html[Kibana User Guide].

[[load-kibana-dashboards]]
==== Loading Kibana Dashboards

Kibana has a large set of visualization types that you can combine to create
the perfect dashboards for your needs. But this flexibility can be a bit
overwhelming at the beginning, so we have created a couple of
https://github.com/elastic/beats-dashboards[Sample Dashboards] to get you
started and to demonstrate what is possible based on the Beats data.

To load the sample dashboards, follow these steps:

["source","sh",subs="attributes,callouts"]
----------------------------------------------------------------------
curl -L -O http://download.elastic.co/beats/dashboards/beats-dashboards-{Dashboards-version}.tar.gz
tar xzvf beats-dashboards-{Dashboards-version}.tar.gz
cd beats-dashboards-{Dashboards-version}/
./load.sh
----------------------------------------------------------------------

NOTE: If Elasticsearch is not running on `127.0.0.1:9200`, you need to
specify the Elasticsearch location as an argument to the `load.sh` command:
`./load.sh http://192.168.33.60:9200`

The load command uploads the example dashboards, visualizations, and searches
that you can use. The load command also creates index patterns for each Beat:

   - [packetbeat-]YYYY.MM.DD
   - [topbeat-]YYYY.MM.DD
   - [filebeat-]YYYY.MM.DD

After loading the dashboards, Kibana raises a `No default index
pattern` error. You must select or create an index pattern to continue. You can
resolve the error by refreshing the page in the browser and then setting one of
the predefined index patterns as the default.

image:./images/kibana-created-indexes.png[Kibana configured indexes]

To open the loaded dashboards, go to the `Dashboard` page and click the
*Load Saved Dashboard* icon. Select `Packetbeat Dashboard` from the list.
You can then easily switch between the dashboards by using the `Navigation` widget.

image:./images/kibana-navigation-vis.png[Navigation widget in Kibana]

Of course, you won't see actual data until you've installed and
configured your Beat.

Enjoy!