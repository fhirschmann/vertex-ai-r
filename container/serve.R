#!/usr/bin/env Rscript
Sys.getenv()
library(plumber)

http_port <- as.numeric(Sys.getenv("AIP_HTTP_PORT"))

pr <- plumber::plumb("api.R")
pr$run(host='0.0.0.0', port=http_port)
