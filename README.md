# EPP IaC repo

This repository contains all the code for defining EPP's external infrastructure on AWS

# Infrastructure

- S3 Bucket
- policy granting access read/write to S3 Bucket
- Role with read/write policy applied and granted to EKS cluster service account via IRSA
