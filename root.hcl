locals {
    account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))


    account_id              = local.account_vars.locals.aws_account_id
    account_name            = local.account_vars.locals.account_name
    aws_region              = local.region_vars.locals.aws_region
    tf_statefile_aws_region = local.region_vars.locals.tf_statefile_aws_region
}

generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  allowed_account_ids = ["${local.account_id}"]
  #ssume_role {
   #role_arn = "arn:aws:iam::${local.account_id}:role/Terraform-Admin-Role"
  #
}
EOF
}

remote_state {
    backend = "s3"
    config = {
        bucket         = "${local.region_vars.locals.tf_state_bucket}"
        key            = "${get_env("TG_BUCKET_PREFIX", "terraform")}/${path_relative_to_include()}/terraform.tfstate"
        region         = "${local.tf_statefile_aws_region}"
        encrypt        = true
        dynamodb_table = "terraform-locks"
        #role_arn       = "arn:aws:iam::${local.account_id}:role/Terraform-Admin-Role"
    }
    generate = {
        path      = "provider.tf"
        if_exists = "overwrite_terragrunt"
    }
}

inputs = merge(
    local.account_vars.locals,
    local.region_vars.locals,
    local.environment_vars.locals,
)