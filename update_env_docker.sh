#!/usr/bin/env bash
VERSION=$1
wget https://raw.githubusercontent.com/wedavey/atnlp/v${VERSION}/envprod.yml
sed -i "s:- atnlp.*:- atnlp==${VERSION}:g" envprod.yml
conda env create -n temp -f envprod.yml
source activate temp
conda env export > ${DATADIR}/newenv.yml
source deactivate
conda remove --name temp --all -y
rm envprod.yml