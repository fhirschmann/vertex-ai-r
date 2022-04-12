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
#* @serializer json
function(req) {
    print(req)
    body <- fromJSON(req$postBody)
 
    df <- body$instances
    preds <- predict(rf, df)

    return(list(predictions=preds))
    #return(list(predictions=c(1, 2, 3)))
}
