#!/usr/bin/env Rscript
# filename: train.R - train a Random Forest model on Vertex AI Managed Dataset
library(tidyverse)
library(data.table)
library(randomForest)
Sys.getenv()

project_id <- Sys.getenv("CLOUD_ML_PROJECT_ID")
job_spec <- Sys.getenv("CLOUD_MD_JOB")
location <- Sys.getenv("CLOUD_ML_REGION")
model_dir <- Sys.getenv("AIP_MODEL_DIR")
checkpoint_dir <- Sys.getenv("AIP_CHECKPOINT_DIR")

dir.create("training")
dir.create("validation")
dir.create("test")
system2("gsutil", c("cp", Sys.getenv("AIP_TRAINING_DATA_URI"), "training/"))
system2("gsutil", c("cp", Sys.getenv("AIP_VALIDATION_DATA_URI"), "validation/"))
system2("gsutil", c("cp", Sys.getenv("AIP_TEST_DATA_URI"), "test/"))
training_df <- list.files("training", full.names = TRUE) %>% map_df(~fread(.))
validation_df <- list.files("validation", full.names = TRUE) %>% map_df(~fread(.))
test_df <- list.files("validation", full.names = TRUE) %>% map_df(~fread(.))

print(training_df)

rf <- randomForest(medianHouseValue ~ ., data=training_df, ntree=100)
rf

saveRDS(rf, "rf.rds")
system2("gsutil", c("cp", "rf.rds", model_dir))
