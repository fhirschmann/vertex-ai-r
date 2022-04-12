#!/usr/bin/env Rscript
Sys.getenv()
library(plumber)

system2("gsutil", c("cp", "-r", Sys.getenv("AIP_STORAGE_URI"), "."))

pr <- plumber::plumb("api.R")
pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv("AIP_HTTP_PORT")))
