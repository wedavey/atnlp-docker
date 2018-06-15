#!/bin/bash
conda create --name temp python=3 -y
source activate temp
conda install -y --file requirements.txt
conda env export > ${DATADIR}/newenv.yml
source deactivate
conda remove --name temp --all -y
