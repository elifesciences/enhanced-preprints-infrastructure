validate-task = (cd env/$1/ && terraform init -backend=false && terraform validate)
plan-task = (cd env/$1/ && terraform plan -out plan.plan)
plan-apply-task = (cd env/$1/ && terraform apply plan.plan)
apply-task = (cd env/$1/ && terraform apply)


lint:
	tflint --init
	tflint --recursive --minimum-failure-severity=error

validate: prod-validate staging-validate

prod-validate:
	$(call validate-task,prod)

staging-validate:
	$(call validate-task,staging)

staging-plan:
	$(call plan-task,staging)

staging-plan-apply:
	$(call plan-apply-task,staging)

staging-apply:
	$(call apply-task,staging)

prod-plan:
	$(call plan-task,prod)

prod-plan-apply:
	$(call plan-apply-task,prod)

prod-apply:
	$(call apply-task,prod)
