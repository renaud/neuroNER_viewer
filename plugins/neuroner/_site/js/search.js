
var myindex = 'neuroner_20150504_ft';

var client = new elasticsearch.Client({ //log: 'trace'
  //host: 'http://128.178.51.90:9200',
  host: 'localhost:9200',
});


function simple_search(query_str, _size, _from){
  client.search({
    index: myindex,
    body: {
      size: _size,
      from: _from,
      "query": {
        "nested": {
          "path": "neuron.neuron_properties",
          "query": {
            "bool": {
              "must": [
                {
                  "match": {
                    "neuron.neuron_properties.property_text": query_str
                  }
                }
              ]
            }
          }
        }
      },
      aggregations: my_aggregations
    }
  }).then(function (resp) {
    display_results(resp, _size, _from);
  }, function (err) {
    console.trace("ES Search error" + err.message);
  });
}

