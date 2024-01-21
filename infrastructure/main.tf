terraform {
  required_version = "1.6.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

