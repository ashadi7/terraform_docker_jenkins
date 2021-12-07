.PHONY: assume-role
assume-role:
      AWSCreds := $(shell curl -v http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins)
      @echo $AWSCreds

.PHONY: tf-init
tf-init:
	docker-compose -f deploy/docker-compose.yml run terraform init

.PHONY: tf-fmt
tf-fmt:
	docker-compose -f deploy/docker-compose.yml run terraform fmt

.PHONY: tf-validate
tf-validate:
	docker-compose -f deploy/docker-compose.yml run terraform validate

.PHONY: tf-plan
tf-plan:
	docker-compose -f deploy/docker-compose.yml run terraform plan

.PHONY: tf-apply
tf-apply:
	docker-compose -f deploy/docker-compose.yml run terraform apply

.PHONY: tf-destroy
tf-destroy:
	docker-compose -f deploy/docker-compose.yml run terraform destroy
