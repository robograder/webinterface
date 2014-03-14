"""
Wraps Dada, taking care of things
"""
import tempfile
import json
import subprocess

import words

class DadaGrammar(object):

    DADA_COMMAND = "dada"

    def __init__(self):
        self.grammar_template = None
        self.word_source = words.WordSource()

    def get_grammar_data(self):
        return {
            "noun_countable" : self.word_source.get_countable_nouns(),
            "noun_uncountable" : self.word_source.get_uncountable_nouns(),
            "adverbs" : self.word_source.get_adverbs(),
            "adjectives" : self.word_source.get_adjectives(),
            "verb_intrans" : self.word_source.get_intransitive_verbs(),
            "verb_trans" : self.word_source.get_transitive_verbs(),
        }

    def render(self):
        if self.grammar_template is None:
            raise  ValueError("grammar_template must be set")

        # Get the Vocab data for rendering
        data = self.get_grammar_data()

        # Get temp file
        temp = tempfile.NamedTemporaryFile()

        # Dump data to the tempfile
        json.dump(data, temp)
        temp.flush()

        # Do a dada!
        cmd = [self.DADA_COMMAND, '-j', temp.name, self.grammar_template]

        try:
            return subprocess.check_output(cmd)
        except subprocess.CalledProcessError as e:
            return "ERROR: " + str(e)
