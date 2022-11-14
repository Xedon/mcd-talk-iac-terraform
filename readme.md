# IaC with Terraform

## Requirements

- docker
- make
- aws-vault

## How to deploy application

- comment backend block in `bootstrap/provider.tf`
- `make boostrap-init`
- `make boostrap-apply`
- fill bucket string in `bootstrap/provider.tf` and `application/provider.tf` with ouput from `make boostrap-apply`
- remove comments on backend block in `bootstrap/provider.tf`
- `make boostrap-migrate`

- `make application-init`
- `make env=test workspace-new` (env is the variable for the environment you want to deploy)
- `make env=test application-apply` (env is the variable for the environment you want to deploy)
- `make env=production workspace-new` (env is the variable for the environment you want to deploy)
- `make env=production application-apply` (env is the variable for the environment you want to deploy)
