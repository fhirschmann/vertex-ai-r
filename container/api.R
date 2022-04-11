#!/usr/bin/env Rscript
rf <- readRDS("artifacts/rf.rds")

library(randomForest)
library(jsonlite)

#* Vertex Health Route
#* @get /v1/endpoints/<endpoint>/deployedModels/<model>
#* @serializer text
function(req) {
    return("ok")
}

#* Vertex Predict Route
#* @post /v1/endpoints/<endpoint>/deployedModels/<model>:predict
function(req) {
    body <- fromJSON(req$postBody)
 
    df <- body$instances
    print(df)
    preds <- predict(rf, df)
    print(preds)
    return(list(predictions=preds))
}
