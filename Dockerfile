FROM rocker/r-ver:4.1.3
WORKDIR /root

COPY train.R /root/train.R

RUN apt-get update
RUN apt-get install -yy curl apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-cli

RUN Rscript -e "install.packages('randomForest', repos = 'http://cran.us.r-project.org')"

ENTRYPOINT ["Rscript", "/root/train.R"]
