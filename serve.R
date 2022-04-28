#!/usr/bin/env Rscript
# filename: serve.R - serve predictions from a Random Forest model
Sys.getenv()
library(plumber)

#system2("gsutil", c("cp", "-r", Sys.getenv("AIP_STORAGE_URI"), "."))

predict <- function(req, res) {
    return(list(predictions=list(1, 2, 3)))
}

pr() %>%
    pr_get(Sys.getenv("AIP_HEALTH_ROUTE"), function() "OK") %>%
    pr_post(Sys.getenv("AIP_PREDICT_ROUTE"), predict) %>%
    pr_run(host = "0.0.0.0", port=as.integer(Sys.getenv("AIP_HTTP_PORT", 8080)))
