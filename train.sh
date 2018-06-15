#!/bin/bash
cd $(mktemp -d)
for MODEL in ${MODELS}; do 
    train.py ${DATADIR}/data_train.txt ${DATADIR}/labels_train.txt -m ${MODEL}
done
mv * ${DATADIR}
