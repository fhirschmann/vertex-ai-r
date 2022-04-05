#!/bin/bash
source vars

docker build -f Dockerfile -t ${IMAGE_URI} ./

#docker run ${IMAGE_URI}

docker push ${IMAGE_URI}
