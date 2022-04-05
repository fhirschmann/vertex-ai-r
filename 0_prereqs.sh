#!/bin/bash
source vars

gcloud services enable artifactregistry.googleapis.com

gcloud artifacts repositories create vertex-r \
    --repository-format=docker \
    --location=${LOCATION}

gcloud auth configure-docker ${LOCATION}-docker.pkg.dev

gsutil mb -l ${LOCATION} gs://${BUCKET}
