#!/bin/bash
source vars

cd container

#docker build -f Dockerfile -t ${IMAGE_URI} ./
#docker push ${IMAGE_URI}
gcloud builds submit --region=$LOCATION --tag $IMAGE_URI
