Visualization frontend for [neuroNER](https://github.com/renaud/neuroNER)
========

Author: renaud.richardet@epfl.ch


### Requirements

* Java Runtime Engine
* HDD space: depends on Elasticsearch index size


### Configure

* copy the data directory (it contains the ES index)
* specify the ES index in `plugins/neuroner/config.js`


### Start

* start ES server with `./bin/elasticsearch`
* navigate to (http://localhost:9200/_plugin/neuroner/)
* index admin interface: (http://localhost:9200/_plugin/head/)
    
    
### TODOs

* add author and year to PubMed link
