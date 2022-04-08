#!/usr/bin/env Rscript
#library(randomForest)
#rf <- readRDS("rf.rds")

#* Vertex Health Route
#* @get /v1/endpoints/<endpoint>/deployedModels/<model>
#* @serializer text
function(endpoint, model) {
    return("ok")
}

#* Vertex Predict Route
#* @post /v1/endpoints/<endpoint>/deployedModels/<model>:predict
function(endpoint, model) {
    return(42)
}
