#!/bin/bash
source vars

cd ..
gcloud builds submit --region=$LOCATION --tag $IMAGE_URI --timeout=1h
