```
output {
    stdout { codec => rubydebug { metadata => true } }
  }



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


{:event=>{"message"=>"ccc", "@version"=>"1", "@timestamp"=>"2015-12-17T11:55:04.067Z", "count"=>1, "fields"=>nil, "fileinfo"=>{}, "input_type"=>"log", "line"=>15, "offset"=>7311, "shipper"=>"uat-kcic", "source"=>"/var/log/dpkg.log", "type"=>"log"}, :level=>:debug, :file=>"(eval)", :line=>"21", :method=>"output_func"}
```