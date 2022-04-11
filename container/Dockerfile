FROM rocker/tidyverse:4.1
WORKDIR /root

COPY train.R /root/train.R
COPY serve.R /root/serve.R
COPY api.R /root/api.R

# Install the Google Cloud SDK
RUN apt-get update
RUN apt-get install -yy curl apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-cli

# Install R packages
RUN install2.r --error plumber
RUN install2.r --error randomForest
RUN install2.r --error jsonlite

EXPOSE 8080
