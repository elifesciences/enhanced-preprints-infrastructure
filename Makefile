lint:
	tflint --init
	tflint --recursive --minimum-failure-severity=error

validate: validate-prod validate-staging

validate-prod:
	cd env/prod && terraform init -backend=false
	cd env/prod/ && terraform validate

validate-staging:
	cd env/staging && terraform init -backend=false
	cd env/staging/ && terraform validate
