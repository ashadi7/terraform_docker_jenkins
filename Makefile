.PHONY: tf-init
tf-init:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}"  terraform init

.PHONY: tf-fmt
tf-fmt:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" terraform fmt

.PHONY: tf-validate
tf-validate:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" terraform validate

.PHONY: tf-plan
tf-plan:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" terraform plan

.PHONY: tf-apply
tf-apply:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" terraform apply

.PHONY: tf-destroy
tf-destroy:
	docker-compose -f deploy/docker-compose.yml run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e WS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SECURITY_TOKEN="${AWS_SESSION_TOKEN}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" terraform destroy
