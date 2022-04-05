#!/bin/bash

gcloud ai-platform jobs submit training vertexr \
    --region $LOCATION \
    --master-image-uri $IMAGE_URI
