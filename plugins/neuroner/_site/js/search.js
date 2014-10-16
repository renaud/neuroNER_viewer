
var myindex = 'neuroner_20141014_2';

var client = new elasticsearch.Client({
  host: 'localhost:9200',
  //log: 'trace'
});

function simple_search(query_str, _size, _from){
  client.search({
    index: myindex,
    body: {
      size: _size,
      from: _from,
      query: {
        bool: {
          must: [
          {
            term: {
              sentence_text: query_str
            }
          }
          ]
        }
      }
    }
  }).then(function (resp) {
    display_results(resp.hits, _size, _from);
  }, function (err) {
    console.trace("ES Search error" + err.message);
  });
}


function aggregate_classes(){
  client.search({
    index: myindex,
    body: {
      size: 0,
      aggregations: {
        "agg__neuron_properties": {
          nested: {
            path: "neuron.neuron_properties"
          },
          aggregations: {
            "agg__type_": {
              terms: {
                field: "neuron.neuron_properties.neuron_type"
              }
            }
          }
        }
      }
    }
  }).then(function (resp) {
    display_classes(resp.aggregations.agg__neuron_properties.agg__type_.buckets);
  }, function (err) {
    console.trace(err.message);
  });
}

function search_by_class(_class){
  client.search({
    index: myindex,
    body: {
      query: {
        nested: {
          path: "neuron.neuron_properties",
          query: {
            match: {
              "neuron.neuron_properties.neuron_type": _class
            }
          }
        }
      }
    }
  }).then(function (resp) {
    console.log(resp);
    display_results(resp.hits, 100, 0);
  }, function (err) {
    console.trace(err.message);
  });
}
