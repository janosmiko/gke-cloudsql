variable "project" {
  description = "The GCP Project ID."
}

variable "region" {
#  default = "us-east4"
  description = "The GCP Region where the resources will be installed."
}

variable "zone" {
#  default = "us-east4-a"
  description = "The GCP Zone where the resources will be installed. It has to be a part of the region."
}

variable "cloud_sql_postgres_user" {
  default = "user"
  description = "The Cloud SQL Postgres user name."
}
