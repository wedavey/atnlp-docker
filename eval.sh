#!/bin/bash
PKLS=$(for MODEL in ${MODELS}; do echo $MODEL.pkl; done | paste -s -d' ')
cd $(mktemp -d)
evaluate.py ${DATADIR}/data_train.txt ${DATADIR}/labels_train.txt ${PKLS}
mv * ${DATADIR}
