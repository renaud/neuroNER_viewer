#!/bin/bash

if [ "$#" -ne 1 ]
then
  echo "need one arg, the index name"
  exit 1
fi


curl -XPOST localhost:9200/$1 -d '{
    "mappings": {
        "abstract_": {
            "properties": {
                "abstract_text": {
                    "type": "string",
                    "store" : true
                },
                "authors" : {
                    "type": "string",
                    "store" : true
                },
                "published_date" : {
                    "type": "date"
                },
                "pmid": {
                    "type": "long"
                },
                "neuron": {
                    "type" : "nested",
                    "properties": {
                        "neuron_text": {
                            "type" : "string",
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
                                "end": {
                                    "type": "long"
                                },
                                "property_text": {
                                    "type": "string",
                                    "index": "not_analyzed",
                                    "fields": {
                                       "analyzed": {
                                          "type": "string",
                                          "index": "analyzed"
                                       }
                                    }
                                },
                                "onto_id": {
                                    "type": "string",
                                    "index": "not_analyzed"
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
                },

                "all_neuron_properties": {
                    "type" : "nested",
                    "properties": {
                        "neuron_type": {
                            "type": "string"
                        },
                        "start": {
                            "type": "long"
                        },
                        "end": {
                            "type": "long"
                        },
                        "property_text": {
                            "type": "string",
                            "index": "not_analyzed",
                            "fields": {
                               "analyzed": {
                                  "type": "string",
                                  "index": "analyzed"
                               }
                            }
                        },
                        "onto_id": {
                            "type": "string",
                            "index": "not_analyzed"
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
}'
