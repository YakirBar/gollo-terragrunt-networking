locals {
  external_locals = read_terragrunt_config(find_in_parent_folders("locals.hcl")).locals
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket = "${local.external_locals.bucket}"
    region = "${local.external_locals.region}"
    key    = "${path_relative_to_include()}/terraform.tfstate"
  }
}
EOF
}
