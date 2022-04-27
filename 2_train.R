#!/usr/bin/env Rscript
library(MASS)

project_id <- Sys.getenv("PROJECT_ID")
location <- Sys.getenv("LOCATION")
bucket <- Sys.getenv("BUCKET")
image_uri <- Sys.getenv("IMAGE_URI")
data_uri <- paste0("gs://", bucket, "/boston.csv")

library(reticulate)
use_python(Sys.which("python3"))

vertex <- import("google.cloud.aiplatform")

vertex$init(project=project_id, location=location, staging_bucket=bucket)

write.csv(Boston, "boston.csv", row.names=FALSE)
system2("gsutil", c("cp", "boston.csv", data_uri))

dataset <- vertex$TabularDataset$create(
    display_name="Boston Housing Dataset",
    gcs_source=data_uri
)

job <- vertex$CustomContainerTrainingJob(
    display_name="vertex-r",
    container_uri=image_uri,
    command=c("Rscript", "train.R"),
    model_serving_container_command=c("Rscript", "serve.R"),
    model_serving_container_image_uri=image_uri
)

model <- job$run(
    dataset=dataset,
    model_display_name="vertex-r-model",
    machine_type="n1-standard-4"
)

print(model$display_name)
print(model$resource_name)
print(model$uri)

endpoint <- vertex$Endpoint$create(
    display_name="Boston Housing Endpoint",
    project=project_id,
    location=location
)

model$deploy(endpoint=endpoint, machine_type="n1-standard-4")

library(jsonlite)
examples <- toJSON(head(Boston))
write(examples, "examples.json")

cleanup <- function() {
    endpoint$undeploy_all()
    endpoint$delete()
    dataset$delete()
    model$delete()
    job$delete()
}
