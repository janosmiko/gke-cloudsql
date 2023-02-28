# GKE + Cloud SQL Terraform template

This repository contains the Terraform resources to create a production-ready GKE Cluster (with one or more node pools)
and a Cloud SQL. It provides the requirements to access the Cloud SQL from within the GKE Cluster.

## Pipelines

There is a multiple pipeline that run on Pull Request to the `main` branch. It is triggered if there are
any changes in the `environments/dev` or in the `modules` directories. It initializes
Terraform and runs `terraform plan` to check for any errors. A GitHub comment is posted with the output of the plan to
the Pull Request.

If the Pull Request is merged, the pipeline will run `terraform apply` to apply the changes to GCP.

## Structure

The `environments/...` directories contain the environment files while the `modules` directory contains the reusable
Terraform modules that are used in the environments.

### Dev

The `environments/dev` directory contains the resources for the dev environment.

* A dev Kubernetes cluster
* A Cloud SQL
* Service Accounts
* and more...

### Modules

* `k8s_cluster` - Create the GKE cluster (it's configured to use one node pool, and it configures a weekly backup).
* `cloud_sql` - Create a Google Cloud SQL PostgreSQL instance with the required network dependencies, an endpoint, and
  databases and users.

## Usage

It reads the Cloud SQL user's password from a GCP Secret Manager secret
called `${terraform.workspace}-cloud-sql-user-password`. You can change this behaviour by changing the secret in
the `environments/dev/cloud_sql.tf` file.

The setup utilises .envrc files to set the environment variables. You can use the `direnv` tool to automatically read
the .envrc file.
Terraform version is managed by tfenv.

Example usage:

```console
$ cd environments/dev
$ direnv allow
$ tfenv install
$ terraform init
$ terraform plan
$ terraform apply
```