# We use both google and google-beta providers as some of the used resources (eg: kubernetes backup) are not yet
# available in the google provider.
provider "google" {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

# The current Google cli client.
data "google_client_config" "provider" {}

# The Helm and Kubernetes providers are using the credentials of the Kubernetes cluster terraform creates in the
# `k8s_cluster.tf`.
provider "helm" {
  kubernetes {
    host                   = "https://${module.k8s_cluster.endpoint}"
    cluster_ca_certificate = base64decode(module.k8s_cluster.ca_cert)
    token                  = data.google_client_config.provider.access_token
  }
}

provider "kubernetes" {
  host                   = "https://${module.k8s_cluster.endpoint}"
  cluster_ca_certificate = base64decode(module.k8s_cluster.ca_cert)
  token                  = data.google_client_config.provider.access_token
}