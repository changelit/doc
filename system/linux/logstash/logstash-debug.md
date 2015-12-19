## Debug information

#### Logstash Debug mode

* set indexer.conf as following 
```
output {
    stdout { codec => rubydebug { metadata => true } }
  }
```

 * start logstash in debug mode 
```json
  ./bin/logstash --debug -f /etc/logstash/conf.d/index.conf
```
* then you can see output from console 

```yaml
       "message" => "ccc",
      "@version" => "1",
    "@timestamp" => "2015-12-17T11:51:34.061Z",
         "count" => 1,
        "fields" => nil,
      "fileinfo" => {},
    "input_type" => "log",
          "line" => 10,
        "offset" => 7291,
       "shipper" => "uat-kcic",
        "source" => "/var/log/dpkg.log",
          "type" => "log",
     "@metadata" => {
        "beat" => "uat",
        "type" => "log"
```

* what you should notice on logstash 
. when you define fields on filebeat.yml ,you must not want to use "-", like server-abc ,it has a problem with search  

#### Kibana 

* search syntax
```
account_number:<100 AND balance:>47500
```

* what is indexer ?

. In the elasticsearch data directory , you can see tree like this "$elastic_data/$elastic_cluster/nodes/$node_number/indices/$indices"

. so you should set index depend on the data in this directory in kibana web  

. Anather one you should take care about ,Kibana has no access authorization ,so you should add base_auth in apache or nginx  

