variable "db_username" {
  description = "Database username for MLflow"
  type        = string
  default = "mlflowuser"
}

variable "db_password" {
  description = "Database password for MLflow"
  type        = string
}

variable "db_host" {
  description = "Database host for MLflow"
  type        = string
  default     = "localhost"
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
  default = "f744124c7589678dcd5f9af0a3ac4de50978f916"
}
