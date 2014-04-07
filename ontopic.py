"""
exposed function get_related, to return set of n synonyms / related word (up to n)
"""
import sys
import random

from nltk.corpus import wordnet

# Set to True to attempt to walk wordnet to find
# related words.
INCLUDE_RELATED = False

def get_related(word):

    synsets = wordnet.synsets(word)
    if not synsets:
        # no words!
        return None
    # for now, grab first one
    synset = synsets[0]

    out = []
    out.append(word) # put it in!
    out.append(word) # twice!

    synonyms = [l.name.replace('_', ' ') for l in synset.lemmas]

    # add all the synonyms, twice
    # so that they are more likely to appear
    for s in synonyms:
        out.append(s)
        out.append(s)


    if INCLUDE_RELATED:
        relates = [
        'hypernyms', 'instance_hypernyms',
        'hyponyms', #'instance_hyponyms',
        'member_holonyms', 'substance_holonyms', 'part_holonyms',
        'member_meronyms', 'substance_meronyms', 'part_meronyms',
        'attributes',
        'entailments',
        'causes',
        'also_sees',
        'verb_groups',
        'similar_tos',
        ]


        for related in relates:
            for syn in getattr(synset, related)():
                for l in syn.lemmas:
                    out.append(l.name.replace('_', ' '))

    # no abbreviations
    out = [w for w in out if not w.isupper()]

    return out

    # grow it.
    next_level = 8


if __name__ == "__main__":
    word = sys.argv[1]
    print "%s:" % word
    print get_related(word)
