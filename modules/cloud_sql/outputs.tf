output "address" {
  value = google_sql_database_instance.this.private_ip_address
}

output "service_account" {
  value = var.create_service_account ? google_service_account.this[0].email : ""
}
