var query2 =
{
  "aggregations": {
    "agg__neuron_properties": {
      "aggregations": {
        "agg__neuron_type": {
          "aggregations": {
            "agg__property_text": {
              "terms": {
                "field": "neuron.neuron_properties.property_text",
                "size": 0
              }
            }
          },
          "terms": {
            "field": "neuron.neuron_properties.neuron_type",
            "size": 0
          }
        }
      },
      "nested": {
        "path": "neuron.neuron_properties"
      }
    }
  },
  "query": {
    "nested": {
      "path": "neuron.neuron_properties",
      "query": {
        "bool": {
          "must": [
            {
              "match": {
                "neuron.neuron_properties.neuron_type": "brainregion"
              }
            }
          ]
        }
      }
    }
  },
  "size": 0
}
