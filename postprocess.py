import re
import nltk
from nltk.corpus import cmudict

CMUDICT = cmudict.dict()

# check that there are any letters, making this string a "word"
def is_word(word):
    return re.search('\w*', word) != None

def strip_punctuation(word):
    return word.strip('.?!,:;()')

class TokenizedText:
    def __init__(self, text):
        self.original_text = text
        self.words = text.split(' ')
        self.index = -1

        # ensure that we start at an actual word
        self.next_word()
        self.initial_index = self.index

    def get_new_text(self):
        return ' '.join(self.words)

    def get_original_text(self):
        return self.original_text

    # reset to first actual word in text
    def reset_index(self):
        self.index = self.initial_index

    def previous_word(self):
        while True:
            self.index -= 1
            if self.index < 0:
                return None
            cur_word = self.words[self.index]
            if is_word(cur_word):
                return strip_punctuation(cur_word)
        
    def next_word(self):
        while True:
            self.index += 1
            if self.index >= len(self.words):
                return None
            cur_word = self.words[self.index]
            if is_word(cur_word):
                return strip_punctuation(cur_word)

    def cur_word(self):
        if self.index < 0 or self.index >= len(self.words):
            return None
        else:
            return strip_punctuation(self.words[self.index])

    def current_index(self):
        return self.index

    def replace_word(self, index, new_word):
        old_word = self.words[index]
        if is_word(old_word):
            # save the punctuation!
            parts = re.split('(\w.*\w|\w)', old_word)
            # if old_word has letters, this should split into a list of length 3
            new_word_full = parts[0] + new_word + parts[2]

            self.words[index] = new_word_full

    def replace_current_word(self, new_word):
        replace_word(self.index, new_word)

# determine whether a word begins with a vowel sound
def begins_with_vowel_sound(word, pronunciations=CMUDICT):
    # use only the first pronunciation
    # cmudict.dict().get(word) returns a list of pronunciations, which are lists of sounds represented as strings; the string ends in a digit iff the sound is a vowel
    return pronunciations.get(word)[0][0][-1].isdigit() if word in pronunciations else word[0] in ('a', 'e', 'i', 'o', 'u')

# Choose the correct indefinite article (a/an) depending on whether the next word begins with a vowel
def fix_indefinite_articles(essay):
    words = TokenizedText(essay)
    
    last_word = words.cur_word()
    last_index = words.current_index()

    while True:
        cur_word = words.next_word()

        if cur_word == None:
            break
        if last_word.lower() == 'a':
            if begins_with_vowel_sound(cur_word.lower()):
                # somewhat hacky--preserve capitalization
                words.replace_word(last_index, last_word + 'n')
        elif last_word.lower() == 'an':
            if not begins_with_vowel_sound(cur_word.lower()):
                # somewhat hacky--preserve capitalization
                words.replace_word(last_index, last_word[:1])

        last_word = cur_word
        last_index = words.current_index()

    return words.get_new_text()

# will include all steps in the future
def postprocess_all(essay):
    return fix_indefinite_articles(essay)
