# REFERENCE: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
# REFERENCE: https://devopsarena.medium.com/provision-gke-cluster-with-terraform-28bf2973c3d4
# REFERENCE: https://www.fairwinds.com/blog/how-to-use-terraform-with-gke-a-step-by-step-guide-to-deploying-your-first-cluster
# REFERENCE: https://github.com/gruntwork-io/terraform-google-gke/blob/master/modules/gke-cluster/main.tf
# REFERENCE: https://learnk8s.io/terraform-gke

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("./k8-service-account-key.json")
  project     = "k8-assignment-app"
  region      = "us-central1-a"
}

resource "google_container_cluster" "cluster" {
  name               = "emayan-assignment-cluster"
  location           = "us-central1-a"
  initial_node_count = 1

  node_config {
    machine_type = "e2-micro"
    disk_type    = "pd-standard"
    disk_size_gb = 10
    image_type   = "COS_CONTAINERD"
  }
}

output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}
