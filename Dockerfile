FROM r-base
WORKDIR /root

COPY train.R /root/train.R
RUN Rscript -e "install.packages('randomForest', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('googleCloudStorageR', repos = 'http://cran.us.r-project.org')"


ENTRYPOINT ["Rscript", "/root/train.R"]
