#!/bin/bash

if [ "$#" -ne 1 ]
then
  echo "need one arg, the index name"
  exit 1
fi


curl -XPOST localhost:9200/$1 -d '{
    "mappings": {
        "sentence": {
            "properties": {
                "sentence_text": {
                    "type": "string",
                    "store" : true,
                    "index" : "analyzed"
                },
                "pmid": {
                    "type": "long"
                },
                "neuron": {
                    "type" : "nested",
                    "properties": {
                        "neuron_text": {
                            "type" : "string",
                            "index" : "analyzed",
                            "fields" : {
                              "raw" : {"type" : "string"}
                            }
                        },
                        "neuron_properties": {
                            "type" : "nested",
                            "properties": {
                                "neuron_type": {
                                    "type": "string"
                                },
                                "start": {
                                    "type": "long"
                                },
                                "property_text": {
                                    "type": "string",
                                    "index" : "analyzed"
                                },
                                "end": {
                                    "type": "long"
                                }
                            }
                        },
                        "start": {
                            "type": "long"
                        },
                        "end": {
                            "type": "long"
                        }
                    }
                }
            }
        }
    }
}'
