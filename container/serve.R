#!/usr/bin/env Rscript
Sys.getenv()
library(plumber)

pr <- plumber::plumb("/root/api.R")
pr$run(host='0.0.0.0', port=8080)
