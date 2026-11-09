locals {
    environment = read_terragrunt_config(find_in_parent_folders("env.hcl"))
    account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

    infra_environment = local.environment.locals.infra_environment
    app_environment   = local.environment.locals.app_environment
}

terraform {
    source = "../../../../modules/kms"
}

include {
    path = find_in_parent_folders("root.hcl")
}

inputs = {
    is_enabled = true,
    enable_key_rotation = true,
    alias = "kms-key-test"
    tags = {
        "Environment" = local.infra_environment
        "App"         = local.app_environment
        "Account"     = local.account_vars.locals.account_name
    }
}

