#!/usr/bin/env bash
VERSION=$1
docker run --rm -v $(pwd)/data:/data wedavey/atnlp:latest "./update_env_docker.sh ${VERSION}"
cp data/newenv.yml environment_v${VERSION}.yml