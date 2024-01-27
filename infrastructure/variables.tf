
variable "db_password" {
  description = "Database password for MLflow"
  type        = string
}

variable "db_name" {
  description = "Database name for MLflow"
  type        = string
  default     = "mlflowdb"
}

variable "mlflow_artifact_path" {
  description = "Path for MLflow artifacts"
  type = string
  default = "/mlflow/artifacts"
}

variable "mlflow_image_tag" {
  description = "Tag to use for the MLflow server Docker image" 
  type = string
  default = "latest"
}

variable "training_job_image_tag" {
  description = "Tag to use for ML training Docker image"
  type = string
  default = "latest"
}
