include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/YakirBar/gollo-module-networking.git//?ref=main"
  
  extra_arguments "vars" {
    commands = ["plan", "apply", "destroy", "validate", "refresh"]

    arguments = [
      "-var-file=${get_terragrunt_dir()}/config.tfvars"
    ]
  }
}
