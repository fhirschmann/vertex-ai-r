#!/usr/bin/env Rscript

Sys.getenv()

project_id <- Sys.getenv("CLOUD_ML_PROJECT_ID")
job_spec <- Sys.getenv("CLOUD_MD_JOB")
location <- Sys.getenv("CLOUD_ML_REGION")
model_path <- Sys.getenv("AIP_MODEL_DIR")

checkpoint_dir <- Sys.getenv("AIP_CHECKPOINT_DIR")

cat(paste("Using project:", project_id, "\n"))

data(Boston, package="MASS")
library(randomForest)

rf <- randomForest(medv ~ ., data=Boston, ntree=100)

saveRDS(rf, "rf.rds")
system(paste("gsutil cp rf.rds", model_path))

