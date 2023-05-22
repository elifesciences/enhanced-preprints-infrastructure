# Description

We have a few temporary buckets in play, which are dependant on one of the policies and groups in this repo.

We could create separate policy and groups for these repos, but instead we'll import the config and state using the following commands:

```bash
cd env/staging
terraform import module.epp.aws_s3_bucket.pdf_bucket staging-elife-epp-pdf

cd env/prod
terraform import module.epp.aws_s3_bucket.pdf_bucket prod-elife-epp-pdf
terraform import module.epp.aws_s3_bucket.meca_bucket prod-elife-epp-meca
```
