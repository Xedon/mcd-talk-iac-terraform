SHELL=/bin/bash


PROFILE=project44

TERRAFORM_IMAGE=hashicorp/terraform:1.3.3

define TERRAFORM_COMMAND
docker run -ti --rm ${PARAMS} --user $$UID:$$GID --env-file <(aws-vault exec ${PROFILE} -- env | grep ^AWS_) \
-v $(PWD):/project -w /project ${TERRAFORM_IMAGE}
endef

login:
	aws-vault login ${PROFILE}

terraform: PARAMS=--entrypoint /bin/sh
terraform:
	${TERRAFORM_COMMAND}

bootstrap-init:
	${TERRAFORM_COMMAND} -chdir=bootstrap init

bootstrap-plan:
	${TERRAFORM_COMMAND} -chdir=bootstrap plan

bootstrap-apply:
	${TERRAFORM_COMMAND} -chdir=bootstrap apply

bootstrap-destroy:
	${TERRAFORM_COMMAND} -chdir=bootstrap apply -destroy

bootstrap-migrate:
	${TERRAFORM_COMMAND} -chdir=bootstrap init -migrate-state

workspace-new:
ifdef env
	${TERRAFORM_COMMAND} -chdir=application workspace new ${env}
else
	@echo "Please provide env argument"
endif

workspace-select:
ifdef env
	${TERRAFORM_COMMAND} -chdir=application workspace select ${env}
else
	@echo "Please provide env argument"
endif

workspace-list:
	${TERRAFORM_COMMAND} -chdir=application workspace list

workspace-delete:
ifdef env
	${TERRAFORM_COMMAND} -chdir=application workspace delete ${env}
else
	@echo "Please provide env argument"
endif

application-init: workspace-select
	${TERRAFORM_COMMAND} -chdir=application init

application-plan: workspace-select
	${TERRAFORM_COMMAND} -chdir=application plan

application-apply: workspace-select
	${TERRAFORM_COMMAND} -chdir=application apply

application-destroy: workspace-select
	${TERRAFORM_COMMAND} -chdir=application apply -destroy
