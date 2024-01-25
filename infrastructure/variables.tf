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
