# Read the Cloud SQL User Password from Secret Manager
data "google_secret_manager_secret_version" "cloud_sql_user_password" {
  secret = "${terraform.workspace}-cloud-sql-user-password"
}

data "google_compute_network" "default" {
  name = "default"
}

module "cloud_sql" {
  source    = "../../modules/cloud_sql"
  providers = {
    google = google
  }

  name = "${terraform.workspace}-sql"
  project = var.project
  zone = var.zone
  region = var.region
  network_id = data.google_compute_network.default.id

  databases = [ "test" ]
  users = [
    {
      name = var.cloud_sql_postgres_user
      password = data.google_secret_manager_secret_version.cloud_sql_user_password.secret_data
      host = ""
    }
    ]
}

output "cloud_sql_postgres_user" {
  value = var.cloud_sql_postgres_user
}

output "cloud_sql_postgres_password" {
  value = data.google_secret_manager_secret_version.cloud_sql_user_password.secret_data
  sensitive = true
}

output "cloud_sql_address" {
  value = module.cloud_sql.address
}