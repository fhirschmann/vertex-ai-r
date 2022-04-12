#!/usr/bin/env Rscript
Sys.getenv()
library(plumber)

#system2("gsutil", c("cp", "-r", Sys.getenv("AIP_STORAGE_URI"), "."))

predict <- function(req, res) {
    list(predictions=c(1, 2, 3))
}

pr() %>%
    pr_get(Sys.getenv("AIP_HEALTH_ROUTE", "/health"), function() "OK") %>%
    pr_post(Sys.getenv("AIP_PREDICT_ROUTE", "/predict"), predict) %>%
    pr_run(host = "0.0.0.0", port=as.integer(Sys.getenv("AIP_HTTP_PORT"), 8080))
