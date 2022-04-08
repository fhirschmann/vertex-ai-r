#!/bin/bash
source vars

cd container

docker build -f Dockerfile -t ${IMAGE_URI} ./
docker push ${IMAGE_URI}
