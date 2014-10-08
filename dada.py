"""
Wraps Dada, taking care of things
"""
import json
import subprocess

import words

class DadaError(RuntimeError):
    pass

class DadaGrammar(object):

    DADA_COMMAND = "dada"

    def __init__(self, source, topical_nouns):
        self.grammar_template = source
        self.topical_nouns = topical_nouns
        self.word_source = words.WordSource()

    def get_grammar_data(self):
        return {
            "noun_countable" : self.word_source.get_countable_nouns(),
            "noun_uncountable" : self.word_source.get_uncountable_nouns(),
            "adverbs" : self.word_source.get_adverbs(),
            "adjectives" : self.word_source.get_adjectives(),
            "verb_intrans" : self.word_source.get_intransitive_verbs(),
            "verb_trans" : self.word_source.get_transitive_verbs(),
            "topical_nouns" : self.topical_nouns,
        }

    def render(self):
        if self.grammar_template is None:
            raise  ValueError("grammar_template must be set")

        # Get the Vocab data for rendering
        data = self.get_grammar_data()

        # Do a dada, it expects JSON on stdin
        cmd = [self.DADA_COMMAND, '-j', '-', self.grammar_template]

        # Spawn it
        try:
            dada_process = subprocess.Popen(
                cmd,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
        except OSError as e:
            raise DadaError("Unable to start dada: %s" % e.strerror)

        # Feed in data as json to STDIN and get result
        dada_stdout, dada_stderr = dada_process.communicate(json.dumps(data))
        if dada_process.returncode != 0:
            raise DadaError("Dada error: %s" % dada_stderr)

        return dada_stdout
