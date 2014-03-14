import sys

import flask

from dada import DadaGrammar
import postprocess as pp

DEBUG = True

app = flask.Flask(__name__)
app.debug = DEBUG

dada = DadaGrammar()

@app.route("/")
def go():
    return pp.postprocess_all(dada.render())

if __name__ == "__main__":
    if len(sys.argv) > 1:
        port = int(sys.argv[1])
    else:
        port = 8888
    dada.grammar_template = "milo-02.pb"
    app.run('0.0.0.0', port=port)
