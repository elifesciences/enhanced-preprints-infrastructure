# EPP IaC repo

This repository contains all the code for defining EPP's external infrastructure on AWS

# Infrastructure

- S3 Bucket
- policy granting access read/write to S3 Bucket
- Role with read/write policy applied and granted to EKS cluster service account via IRSA

# Run linting and validators

- install `make`, `tflint` and `terraform`
- run `make lint`
- run `make validate`

# Preview changes

Use `terraform plan` within an environment, or use the helpful makefile tasks:

```bash
make staging-plan
make prod-plan
```

# Applying changes

The easiest way to check and apply changes is using the makefile:

```bash
make staging-plan
make staging-plan-apply
```
against staging, then

```bash
make prod-plan
make prod-plan-apply
```
for prod.

The exact output shown in the plan phase is what is applied (via a plan.plan output file). Alternative, you can just apply all outstanding changes using:

```bash
make staging-apply
make prod-apply
```
