
-- ----------------------------------------
-- CREATE TABLES
-- ----------------------------------------

CREATE TABLE `20140915_neurons` (
  `id`          int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pmid`        int(11) unsigned NOT NULL,
  `neuron_id`   int(11) unsigned NOT NULL,
  `sentence_id` int(11) unsigned NOT NULL,
  `beg`         int(5)  unsigned NOT NULL,
  `end`         int(5)  unsigned NOT NULL,
  `type`        varchar(64)      NOT NULL DEFAULT '',
  `txt`         varchar(128)     NOT NULL DEFAULT '',
   PRIMARY KEY (`id`),
   KEY `idx_text`       (`txt`),
   KEY `idx_type`       (`type`),
   KEY `idx_neuron_id`  (`neuron_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `20140915_sentences` (
  `id`          int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sentence_id` int(11) unsigned NOT NULL,
  `txt`         text,
  PRIMARY KEY (`id`),
  KEY `idx_sentence_id` (`sentence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- ----------------------------------------
-- LOAD DATA
-- ----------------------------------------
-- cd db
-- mysql -uroot --local-infile
use neuroner_viewer;
LOAD DATA LOCAL INFILE 'aggregate.tsv' INTO TABLE 20140915_neurons FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' (pmid, neuron_id, sentence_id, beg, end, type, txt);
LOAD DATA LOCAL INFILE 'aggregate_sentences.tsv' INTO TABLE 20140915_sentences FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' (sentence_id, txt);


-- 2nd version
use neuroner_viewer;
CREATE TABLE 20140930_neurons   LIKE 20140915_neurons;
CREATE TABLE 20140930_sentences LIKE 20140915_sentences;
LOAD DATA LOCAL INFILE 'aggregate.tsv' INTO TABLE 20140930_neurons FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' (pmid, neuron_id, sentence_id, beg, end, type, txt);
LOAD DATA LOCAL INFILE 'aggregate_sentences.tsv' INTO TABLE 20140930_sentences FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' (sentence_id, txt);
