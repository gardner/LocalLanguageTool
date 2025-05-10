#!/usr/bin/env bash

mkdir -p ngrams

aria2c -c -x4 -s4 -j4 https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip

(cd ngrams && unzip ../ngrams-en-20150817.zip)

rm -f ngrams-en-20150817.zip

