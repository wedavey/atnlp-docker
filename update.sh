#!/usr/bin/env bash
VERSION=$1
wget https://raw.githubusercontent.com/wedavey/atnlp/v${VERSION}/envprod.yml
source activate atnlp
conda env update -f envprod.yml
pip install atnlp==${VERSION}
conda env export > tmp.yml

echo "UPDATES TO ENVIRONMENT"
diff tmp.yml environment

mv tmp.yml environment.yml