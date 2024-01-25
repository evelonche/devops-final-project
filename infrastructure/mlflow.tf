resource "kubernetes_deployment" "mlflow_server" {
  metadata {
    name = "mlflow-server"
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
      }

      spec {
        container {
          image = "ghcr.io/mlflow/mlflow:v2.9.2"
          name  = "mlflow"

          port {
            container_port = 5000
          }

          env {
            name  = "BACKEND_STORE_URI"
            value = "postgresql://${var.db_username}:${var.db_password}@${var.db_host}/${var.db_name}"
          }

          env {
            name  = "ARTIFACT_ROOT"
            value = "/mlflow"
          }

          volume_mount {
            mount_path = "/mlflow"
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
}

resource "kubernetes_service" "mlflow_server" {
  metadata {
    name = "mlflow-service"
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
}

resource "kubernetes_persistent_volume_claim" "mlflow_pvc" {
  metadata {
    name = "mlflow-pvc"
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

resource "kubernetes_ingress" "mlflow_ingress" {
  metadata {
    name = "mlflow-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.il/add-base-url" = "true"
  }
  spec {
    rule { 
      host = "mlflow-sever.local"
      http {
        path {
          backend {
            service_name = "mlflow-service"
            service_port = 5000
          }
          path = "/"
        }
      }
    }
  }
}
    


