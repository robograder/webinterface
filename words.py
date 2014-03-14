"""
Interface to get certain types of words

currently from robograder/robogen
"""
import sqlite3

class WordSource(object):
    """
    This could be swapped out.
    For now, use the sqlite3 interface to db/words.db
    """

    DATAFILE = "db/words.db"

    def __init__(self):
        pass

    def get_transitive_verbs(self, limit=None):
        return self._get('verb', transitive=True, limit=limit)

    def get_intransitive_verbs(self, limit=None):
        return self._get('verb', transitive=False)

    def get_adjectives(self, limit=None):
        return self._get('adjective', limit=limit)

    def get_countable_nouns(self, limit=None):
        return self._get('noun', limit=limit, countable=True)

    def get_uncountable_nouns(self, limit=None):
        return self._get('noun', limit=limit, countable=False)

    def get_adverbs(self, limit=None):
        return self._get('adverb', limit=limit)

    def _get(self, pos, **kwargs):
        """
        generic. reeeeally should use ORM...
        """
        if pos == 'verb':
            transitive = int(kwargs['transitive'])
        else:
            # kludge - default for non-verbs is 0
            transitive = 0

        if pos == 'noun':
            countable = int(kwargs['countable'])
        else:
            countable = 0

        limit = kwargs.get('limit')
        if limit is None:
            limit = 100

        query = "SELECT word from words where partofspeech=? and transitive=? and countable=? limit ?"

        conn = sqlite3.connect(self.DATAFILE)
        # TODO error checking?
        result = [row[0] for row in conn.execute(query, (pos, transitive, countable, limit))]
        # Some words are stored annotated... :/
        result = [word.split(' ')[0] for word in result]
        return result

if __name__ == "__main__":
    import sys
    ws = WordSource()
    print getattr(ws, "get_%ss" % sys.argv[1])()