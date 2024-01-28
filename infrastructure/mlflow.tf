resource "kubernetes_namespace" "mlflow" {
  metadata {
    labels = {
      app = "mlflow"
    }
    name = "mlflow"
  }
}


resource "kubernetes_deployment" "mlflow_server" {
  metadata {
    name      = "mlflow-server"
    namespace = kubernetes_namespace.mlflow.metadata[0].name
    labels = {
      app = "mlflow"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mlflow"
      }
    }

    template {
      metadata {
        labels = {
          app = "mlflow"
        }
        name = "mlflow-server-pod"
      }

      spec {
        container {
          image = "evelonche/mlflow:${var.mlflow_image_tag}"
          name  = "mlflow"

          port {
            container_port = 5000
          }

          env {
            name  = "BACKEND_STORE_URI"
            value = "postgresql://postgres:${var.db_password}@postgres-service:5432/${var.db_name}"
          }

          env {
            name  = "ARTIFACT_ROOT"
            value = var.mlflow_artifact_path
          }

          volume_mount {
            mount_path = var.mlflow_artifact_path
            name       = "mlflow-volume"
          }
        }

        volume {
          name = "mlflow-volume"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mlflow_pvc.metadata[0].name
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_service.postgres
  ]
}

resource "kubernetes_service" "mlflow_server" {
  metadata {
    name      = "mlflow-service"
    namespace = kubernetes_namespace.mlflow.metadata[0].name
  }

  spec {
    selector = {
      app = "mlflow"
    }

    port {
      port        = 5000
      target_port = 5000
    }

    type = "NodePort"
  }
  depends_on = [
    kubernetes_service.postgres
  ]
}

resource "kubernetes_persistent_volume_claim" "mlflow_pvc" {
  metadata {
    name      = "mlflow-pvc"
    namespace = kubernetes_namespace.mlflow.metadata[0].name
  }


  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}



