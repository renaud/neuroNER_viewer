works!

{
  "fields" : ["neuron.neuron_properties.property_text"],
  "query": {
    "bool": {
      "must": [
        {
          "nested": {
            "path": "neuron.neuron_properties", 
            "query": {
              "bool": {
                "must": [ 
                  { "match": { "neuron.neuron_properties.neuron_type": "Neuron" }}
                ]
        }}}}
      ]
}}}
--------


WORKS!
{
  "size": 0,
  "aggregations": {
    "neuron_properties": {
      "nested": {
        "path": "neuron.neuron_properties"
      },
      "aggs": {
        "type_": {
          "terms": {
            "field": "type_"
          }
        }
      }
    }
  }
}


{
 "query":{"bool":{"must":[{"query_string":{"default_field":"sentence.neuron.neuron_properties.type_","query":"Neuron"}}]}},
  "size": 0,
  "aggregations": {
    "neuron_properties": {
      "nested": {
        "path": "neuron.neuron_properties"
      },
      "aggs": {
        "type_": {
          "terms": {
            "field": "property_text"
          }
        }
      }
    }
  }
}


{
  "query":{"bool":{"must":[{"query_string":{"default_field":"sentence.neuron.properties.type_","query":"Neuron"}}],"must_not":[],"should":[]}},
  "aggs": {
    "myneurons": {
      "nested" : {
        "path" : "properties"
      },
      "terms": {
        "field": "properties.property_text"
      }
    }
  }
}


{
  "size": 0,
  "aggregations": {
    "neurons": {
      "nested": {
        "path": "sentence.neuron"
      },
      "aggregations": {
        "aa": {
          "terms": {
            "field": "property_text"
          }
        }
      }
    }
  },
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "sentence.neuron.neuron_properties.type_": "layer"
          }
        }
      ]
    }
}
}



{
  "size": 0,
  "aggregations": {
    "neurons": {
      "nested": {
        "path": "sentences.neuron.properties"
      },
      "aggs": {
        "terms": {
          "field": "property_text"
        }
      }
    }
  }
}
{
    "aggs" : {
        "resellers" : {
            "nested" : {
                "path" : "resellers"
            },
            "aggs" : {
                "min_price" : { "min" : { "field" : "resellers.price" } }
            }
        }
    }
}
