# Create a Production Kubernetes Cluster with 1 node pool.
module "k8s_cluster" {
  source    = "../../modules/k8s_cluster"
  providers = {
    google-beta = google-beta
  }

  name                                         = "${terraform.workspace}-k8s"
  project                                      = var.project
  environment_type                             = "${terraform.workspace}"
  location                                     = var.zone
  # If you plan to use ROUTES network mode you'll have to use Cloud SQL Proxy sidecar containers for the applications.
  networking_mode                              = "VPC_NATIVE"
  workload_identity_enabled                    = true
  primary_node_pool_machine_type               = "e2-standard-2"
  primary_node_pool_node_count                 = 1
  primary_node_pool_autoscaling_min_node_count = 1
  primary_node_pool_autoscaling_max_node_count = 5
  primary_node_pool_preemptible                = true
  secondary_node_pool_enabled                  = false
  master_authorized_cidr_blocks                = [
    {
      display_name = "allow all"
      cidr_block   = "0.0.0.0/0"
    }
  ]
}

# The Kubernetes cluster's primary IP address.
output "kubernetes_endpoint" {
  value = module.k8s_cluster.endpoint
}

# The Kubernetes cluster's default CA certificate.
output "kubernetes_ca_cert" {
  value     = module.k8s_cluster.ca_cert
  sensitive = true
}

# The Kubernetes cluster's default client certificate.
# (Issued by the Kubernetes module. By default it has no permissions.)
output "kubernetes_client_cert" {
  value     = module.k8s_cluster.client_cert
  sensitive = true
}

# The Kubernetes cluster's default client key.
output "kubernetes_client_key" {
  value     = module.k8s_cluster.client_key
  sensitive = true
}
