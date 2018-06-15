#!/bin/bash
cd $(mktemp -d)
#python ${APPDIR}/atnlp/scripts/reuters/reuters_to_txt.py
reuters_to_txt.py
mv *.txt ${DATADIR}/.
rm -rf ${PWD}
