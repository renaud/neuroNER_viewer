import glob, csv



base = '/nfs4/bbp.epfl.ch/simulation/nlp/data/20140915_neuroner_3nd_scaleout/{}_Neurons_3rd_scaleout.tsv{}'
#files = glob.glob('/nfs4/bbp.epfl.ch/simulation/nlp/data/20140915_neuroner_3nd_scaleout/*_Neurons_3rd_scaleout.tsv')

(global_sentence_id, global_neuron_id) = (0, 0)

with open('aggregate.tsv', 'w', 0) as out_neurons, \
    open('aggregate_sentences.tsv', 'w', 0) as out_sentences:

    for i in xrange(0, 9369):
        print 'reindexing file with id', i
        neuron_file = base.format(i, '')
        sentence_file = base.format(i, '_sentence')

        # to store the max id for this file
        (file_sentence_id, file_neuron_id) = (0, 0)
        # to store the sentence ids of this file
        sentence_ids = []

        # (RE)WRITE NEURONS
        with open(neuron_file, 'r') as ff:
            for l in csv.reader(ff, delimiter='\t', quoting=csv.QUOTE_NONE):
                # pmId, neuron_id, sentence_id, begin, end, type, text
                neuron_id = int(l[1]) + global_neuron_id
                sentence_id = int(l[2]) + global_sentence_id
                sentence_ids.append(sentence_id)

                out_neurons.write('{}\t{}\t{}\t{}\t{}\t{}\t{}\n'.format(
                    l[0], neuron_id, sentence_id, l[3], l[4], l[5], l[6]))

                # find max
                file_sentence_id = max(sentence_id, file_sentence_id)
                file_neuron_id   = max(neuron_id,   file_neuron_id)

        # (RE)WRITE SENTENCES
        with open(sentence_file, 'r') as fff:
            for line in fff:
                fields = line.rstrip().split('\t')
                # sentence_id, text
                sentence_id = int(fields[0]) + global_sentence_id
                text = ' '.join(fields[1:])
                # only write sentences for which we found neurons
                if (sentence_id in sentence_ids):
                    out_sentences.write('{}\t{}\n'.format(sentence_id, text))

        # update globals (with max'es)
        global_sentence_id = global_sentence_id + file_sentence_id
        global_neuron_id   = global_neuron_id   + file_neuron_id

print 'DONE! reindexed', global_neuron_id, 'neurons in total within' , global_sentence_id, 'sentences.'
