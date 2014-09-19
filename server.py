'''
REST endpoint for BR connectivity
for new database format (3 extractors)
'''
from datetime import date
from tornado import ioloop, web, autoreload
import simplejson as json
import pymysql
from pymysql import escape_string
import math, os, codecs
from collections import Counter, defaultdict

# properties
import json
def json_to_obj(s):
    def h2o(x):
        if isinstance(x, dict):
            return type('jo', (), {k: h2o(v) for k, v in x.iteritems()})
        else:
            return x
    return h2o(json.loads(s))
config = json_to_obj(open('config.json').read())


def getMySQLConnection():
    return pymysql.connect(host=config.db.host, user=config.db.user,
        passwd=config.db.pwd, db=config.db.db, charset='utf8');


'''serves index.html'''
class MainHandler(web.RequestHandler):
    def get(self):
        self.render('static/index.html')


class SearchHandler(web.RequestHandler):
    SQL = '''SELECT txt, count(txt) AS cnt FROM `{}` WHERE txt LIKE '{}%' GROUP BY txt ORDER BY cnt DESC'''

    def get(self, query=''):
        conn = getMySQLConnection()
        cur = conn.cursor(pymysql.cursors.DictCursor) #in dictionary mode
        cur.execute(SearchHandler.SQL.format(config.db.table, escape_string(query)))

        hits = cur.fetchall()
        self.write(json.dumps(hits))

''' details about one NeuroProperty'''
class DetailHandler(web.RequestHandler):
    SQL1 = '''SELECT neuron_id , sentence_id, begin, end, pmid FROM `{}` WHERE txt ='{}' LIMIT 20 '''
    SQL2 = '''SELECT sentence_id, text FROM `{}` WHERE sentence_id IN({}) '''

    def get(self, query=''):
        conn = getMySQLConnection()
        cur = conn.cursor(pymysql.cursors.DictCursor) #in dictionary mode
        cur.execute(DetailHandler.SQL1.format(config.db.table, escape_string(query)))

        sentences_ids = []
        neurons = []
        for n in cur.fetchall():
            # {u'sentence_id': 4294967295, u'end': 16634, u'begin': 16622, u'neuron_id': 4294967295}
            sentences_ids.append(str(n['sentence_id']))
            neurons.append(n)
        print 'done neurons'

        cur.execute(DetailHandler.SQL2.format(config.db.table_sentences, ','.join(sentences_ids)))
        sentences = {}
        for i in cur.fetchall():
            sentences[i['sentence_id']] = i['text']
        print 'done sentences'

        self.write(json.dumps({'sentences': sentences, 'neurons': neurons}))


# routes
application = web.Application([
    (r'/', MainHandler),
    (r"/neuron/(.+)", DetailHandler),
    (r"/search/", SearchHandler),
    (r"/search/(.+)", SearchHandler),
    (r'/static/(.*)', web.StaticFileHandler, {'path': 'static/'})
],gzip=True)


if __name__ == "__main__":
    application.listen(config.server.port)
    autoreload.start() # TODO remove in prod
    for dir, _, files in os.walk('static'):
        [autoreload.watch(dir + '/' + f) for f in files if not f.startswith('.')]
    print 'server (re)started, go visit http://localhost:%s' % config.server.port
    ioloop.IOLoop.instance().start()
