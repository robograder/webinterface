"""
exposed function get_synonyms, to return set of n synonyms / related word (up to n)
"""
import sys

from nltk.corpus import wordnet



def get_synonyms(word):

    synsets = wordnet.synsets(word)
    if not synsets:
        # no words!
        return None
    # for now, grab first one
    synset = synsets[0]

    out = []
    out.append(word) # put it in!

    synonyms = [l.name for l in synset.lemmas]

    # add all the synonyms, twice
    # so that they are more likely to appear
    for s in synonyms:
        out.append(s)
        out.append(s)

    # hyponyms, meronyms, homonyms
    for related in (synset.hyponyms(), synset.part_meronyms(), synset.part_holonyms()):
        for syn in related:
            for l in syn.lemmas:
                out.append(l.name.replace('_', ' '))

    return out

    # grow it.
    next_level = 8


if __name__ == "__main__":
    word = sys.argv[1]
    print "%s:" % word
    print get_synonyms(word)
