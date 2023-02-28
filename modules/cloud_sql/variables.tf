variable "name" {}
variable "region" {}
variable "zone" {}
variable "project" {}
variable "network_id" {
  default = null
}
variable "authorized_networks" {
  type    = list(map(string))
  default = []
  #default = [
  #  {
  #    name    = "example"
  #    address = "192.168.0.0/24"
  #  }
  #]
}
variable "deletion_protection" {
  default = true
}

variable "instance_tier" {
  default = "db-f1-micro"
}
variable "database_version" {
  default = "POSTGRES_14"
}
variable "disk_autoresize" {
  default = true
}
variable "disk_size" {
  default = "50"
}
variable "disk_type" {
  default = "PD_SSD"
}

variable "ipv4_enabled" {
  default = false
}

variable "create_network" {
  default = false
}

variable "availability_type" {
  description = "REGIONAL or ZONAL"
  default     = "ZONAL"
}

variable "backup_enabled" {
  default = true
}
variable "backup_binary_log_enabled" {
  default = false
}
variable "backup_start_time" {
  default = null
}

variable "database_flags" {
  default = {}
}

variable "maintenance_window_day" {
  default = "7"
}
variable "maintenance_window_hour" {
  default = "23"
}
variable "maintenance_window_update_track" {
  default = "stable"
}

variable "databases" {
  default = []
}
variable "users" {
  type    = list(map(string))
  default = []
  # Example:
  # default = [
  #   {
  #     name = var.cloud_sql_postgres_user
  #     password = data.google_secret_manager_secret_version.cloud_sql_user_password.secret_data
  #     host = ""
  #   }
  # ]
  #
  # Note: host should be empty string for postgres and "%" for mysql
}
variable "default_remote_host" {
  default = "%"
}
variable "create_dns_record" {
  default = false
}
variable "managed_zone" {
  default = null
}
variable "ttl" {
  default = "300"
}

variable "create_service_account" {
  default = false
}
