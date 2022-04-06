#!/bin/bash
source vars

docker build -f Dockerfile -t ${IMAGE_URI} ./
