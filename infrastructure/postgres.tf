resource "kubernetes_persistent_volume" "postgres" {
  metadata {
    name = "postgres-pv-volume"
    labels = {
      type = "local" 
    }
  }
  spec {
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "manual"
    persistent_volume_source {
      host_path {
        path = "/mnt/data"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "postgres-pvc" {
  metadata {
    name = "postgres-pvc"
    namespace =  kubernetes_namespace.mlflow.metadata[0].name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    namespace = kubernetes_namespace.mlflow.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        } 
      }
      spec { 
        volume {
          name = kubernetes_persistent_volume.postgres.metadata[0].name
          persistent_volume_claim {
            claim_name = "postgres-pvc" 
          }
        }
        container {
          name = "postgres"
          image = "postgres:15.5"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 5432
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = var.db_password
          }
          env {
            name = "PGDATA"
            value = "/var/lib/postgresql/data/pgdata"
          }
          env {
            name = "POSTGRES_DB"
            value = var.db_name
          }
          volume_mount {
            mount_path = "/var/lib/postgresql/data/pgdata"
            name = "postgres-pv-volume"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres-service"
    namespace = kubernetes_namespace.mlflow.metadata[0].name
  }
  spec {
    selector = {
      app = "postgres"
    }
    port {
      port = 5432
      target_port = 5432
    }
  }
}
