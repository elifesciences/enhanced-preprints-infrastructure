# EPP IaC repo

This repository contains all the code for defining EPP's external infrastructure on AWS

## Infrastructure

- S3 Bucket
- policy granting access read/write to S3 Bucket
- Role with read/write policy applied and granted to EKS cluster service account via IRSA

## Prerequisites

This repo uses:
- terraform
- tflint
- task

You can get the correct versions by installing [asdf](https://asdf-vm.com/) and running `asdf install`. See `.tool-versions`.

## Tasks

### Preview changes

Use `terraform plan` within an environment, or use the helpful makefile tasks:

```bash
task staging-plan
task prod-plan
```

### Applying changes

The easiest way to check and apply changes is using the taskfile:

```bash
task staging-plan
task staging-plan-apply
```
against staging, then

```bash
task prod-plan
task prod-plan-apply
```
for prod.

The exact output shown in the plan phase is what is applied (via a plan.plan output file). Alternative, you can just apply all outstanding changes using:
