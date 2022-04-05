#!/usr/bin/env Rscript
project_id <- Sys.getenv("PROJECT_ID")
location <- Sys.getenv("LOCATION")
bucket <- Sys.getenv("BUCKET")
image_uri <- Sys.getenv("IMAGE_URI")

library(reticulate)
use_python(Sys.which("python3"))

aiplatform <- import("google.cloud.aiplatform")

aiplatform$init(project=project_id, location=location, staging_bucket=bucket)

job <- aiplatform$CustomContainerTrainingJob(
    display_name="vertex-r",
    container_uri=image_uri,
    model_serving_container_image_uri=image_uri
)

model <- job$run(
    model_display_name="vertex-r-model",
    machine_type="n1-standard-4"

)
