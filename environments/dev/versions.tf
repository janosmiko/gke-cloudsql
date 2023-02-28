terraform {
  # Uncomment the following lines to use the GCS backend.
  #  backend "gcs" {
  #    bucket  = "bucket-name"
  #    prefix  = "prod"
  #  }

  required_version = "~> 1.3.0"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.47.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}
