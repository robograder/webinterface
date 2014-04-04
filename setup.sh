#!/usr/bin/env bash

pip install -r requirements.txt

python -c "import nltk; nltk.download('cmudict')"
python -c "import nltk; nltk.download('wordnet')"
