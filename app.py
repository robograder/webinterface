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
    keywords = [k for k in flask.request.args.getlist('keyword') if k]
    if not keywords:
        if flask.request.args.get('generate') is not None:
            error = "At least one keyword is required!"
        else:
            error = None
        essay = ""
    else:
        error = None
        essay = pp.postprocess_all(dada.render())

    return flask.render_template('essay.html', essay=essay, keywords=keywords, error=error)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        port = int(sys.argv[1])
    else:
        port = 8888
    dada.grammar_template = "milo-02.pb"
    app.run('0.0.0.0', port=port)
