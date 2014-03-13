import sys

import flask

from dada import DadaGrammar

DEBUG = True

app = flask.Flask(__name__)
app.debug = DEBUG

dada = DadaGrammar()

@app.route("/")
def go():
    return dada.render()

if __name__ == "__main__":
    port = int(sys.argv[1])
    dada.grammar_template = "milo-02.pb"
    app.run('0.0.0.0', port=port)