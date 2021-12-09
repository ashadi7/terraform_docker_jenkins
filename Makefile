.PHONY: createenv
createenv:
	-@echo > my_env
	-@echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" >> my_env
	-@echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" >> my_env
	-@echo "AWS_SECURITY_TOKEN=${AWS_SESSION_TOKEN}" >> my_env
	-@echo "AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}" >> my_env

.PHONY: tf-init
tf-init:
	docker-compose -f deploy/docker-compose.yml run   terraform init

.PHONY: tf-fmt
tf-fmt:
	docker-compose -f deploy/docker-compose.yml run  terraform fmt

.PHONY: tf-validate
tf-validate:
	docker-compose -f deploy/docker-compose.yml run  terraform validate

.PHONY: tf-plan
tf-plan:
	docker-compose -f deploy/docker-compose.yml run  terraform plan -input=false tfplan

.PHONY: tf-apply
tf-apply:
	docker-compose -f deploy/docker-compose.yml run  terraform apply -input=false tfplan

.PHONY: tf-destroy
tf-destroy:
	docker-compose -f deploy/docker-compose.yml run  terraform destroy  -input=false tfplan
