var client = new elasticsearch.Client({//log: 'trace'
  host: myhost, // set in config.js
});

function simple_search(query_str, _size, _from){
  client.search({
    index: myindex,
    body: {
      size: _size,
      from: _from,
      /*query: {
        query_string : {
          default_field : "neuron.neuron_text",
          query : query_str
        }
      },*/
      query: {
        nested: {
          path: "neuron",
          query: {
            match: {
              "neuron.neuron_text" : {
                "query":    query_str,
                "operator": "and"
              }
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
