#!/usr/bin/env Rscript
Sys.getenv()
library(plumber)

http_port <- Sys.getenv("AIP_HTTP_PORT")

pr <- plumber::plumb("api.R")
pr$run(host='0.0.0.0', port=8080)
