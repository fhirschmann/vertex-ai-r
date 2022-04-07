#!/usr/bin/env Rscript
bos_rf <- readRDS("rf.rds")
library(randomForest)


#* @param df data frame of variables
#* @post /score
function(req, df)
{
    df <- as.data.frame(df)
    predict(bos_rf, df)
}
