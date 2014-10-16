
curl -XDELETE 'http://localhost:9200/mtest/'

curl -XPOST localhost:9200/mtest -d '{
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



curl -XPUT 'http://localhost:9200/mtest/sentence/1' -d '{"pm_id":"10980480","sentence_text":"\"Mature olfactory receptor neurons express connexin 43.\".","sentence_id":0,"neuron":[{"neuron_text":"\"Mature olfactory receptor neurons","start":0,"end":34,"neuron_properties":[{"neuron_type":"Neuron","property_text":"neurons","start":27,"end":34},{"neuron_type":"Developmental","property_text":"\"Mature","start":0,"end":7},{"neuron_type":"Function","property_text":"olfactory","start":8,"end":17},{"neuron_type":"Function","property_text":"receptor","start":18,"end":26}]}]}'
curl -XPUT 'http://localhost:9200/mtest/sentence/2' -d '{"pm_id":"10672361","sentence_text":"Two principal classes of neurons were distinguished: projection neurons with distant projecting axons and spiny dendrites, and local circuit neurons.","sentence_id":214,"neuron":[{"neuron_text":"neurons","start":25,"end":32,"neuron_properties":[{"neuron_type":"Neuron","property_text":"neurons","start":25,"end":32}]},{"neuron_text":"neurons","start":64,"end":71,"neuron_properties":[{"neuron_type":"Neuron","property_text":"neurons","start":64,"end":71}]},{"neuron_text":"neurons","start":141,"end":148,"neuron_properties":[{"neuron_type":"Neuron","property_text":"neurons","start":141,"end":148}]}]}'

