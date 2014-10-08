"""
Script to (kind of) test requests per second with N concurrent users
"""
import threading
import time
import sys

import requests

LOCAL_URL = 'http://localhost:8888/'
PROD_URL = 'http://babel-generator.herokuapp.com/'

N_CONCURRENT = 50
REQUESTS_PER_CONCURRENT = 10

class UserThread(threading.Thread):

    def __init__(self, n, url):
        threading.Thread.__init__(self)
        self.n = n
        self.url = url

    def run(self):
        start = time.time()
        for _ in range(REQUESTS_PER_CONCURRENT):
            print "%d: getting... (%s)" % (self.n, self.url)
            requests.get(self.url, params={
                'generate':1,
                'keyword':'apple'
            })
        end = time.time()
        self.robo_lag = end - start
        print "%s: done: %f" % (self.n, self.robo_lag)


if __name__ == "__main__":

    url = LOCAL_URL
    try:
        if sys.argv[1] == 'prod':
            url = PROD_URL
    except IndexError:
        # whatever
        pass

    threads = [UserThread(i, url) for i in range(N_CONCURRENT)]
    map(lambda t: t.start(), threads)
    map(lambda t: t.join(), threads)
    tottime = sum(t.robo_lag for t in threads)
    print "TOTAL TIME: %f" % tottime

    tot_n = (REQUESTS_PER_CONCURRENT * N_CONCURRENT)
    print "N REQUESTS: %d" % tot_n
 
    print "AVERAGE LATENCY: %f" % (tottime / tot_n)
    print "THROUGHPUT: %f" % (tot_n / tottime)
