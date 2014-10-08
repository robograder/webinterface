import os
import sys
import random

import flask

from dada import DadaGrammar
import postprocess as pp
import ontopic

PRODUCTION = bool(os.environ.get('PRODUCTION'))

DEBUG = not PRODUCTION

app = flask.Flask(__name__)
app.debug = DEBUG

@app.route("/echo")
def echo():
    return "echo"

@app.route("/")
def go():
    keywords = [k for k in flask.request.args.getlist('keyword') if k]
    if not keywords:
        if flask.request.args.get('generate') is not None:
            error = "At least one keyword is required!"
        else:
            error = None
        essay = ""
        relateds = {}
    else:
        error = None
        topical_nouns = []
        relateds = {}
        for keyword in keywords:
            related = ontopic.get_related(keyword)
            if related is None:
                # thats an error
                error = "unable to find related words for %s. Typo?" % keyword
                break
            for w in related:
                topical_nouns.append(w)
            relateds[keyword] = list(set(related))

        if error:
            essay = ""
        else:
            # make sure theres no more than 100
            if len(topical_nouns) > 100:
                random.shuffle(topical_nouns)
                topical_nouns = topical_nouns[:100]

            dada = DadaGrammar("milo-02.pb", topical_nouns)
            essay = pp.postprocess_all(dada.render())

    return flask.render_template('essay.html', essay=essay, keywords=keywords, relateds=relateds, error=error)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        port = int(sys.argv[1])
    elif 'PORT' in os.environ:
        port = os.environ['PORT']
    else:
        port = 8888

    app.run('0.0.0.0', port=port)
