# Description

We have a few temporary buckets in play, which are dependant on one of the policies and groups in this repo.

To ease integration, we'll import the values into state using the following commands:

```bash
cd env/staging
terraform import module.epp.aws_s3_bucket.pdf_bucket staging-elife-epp-pdf

cd env/prod
terraform import module.epp.aws_s3_bucket.pdf_bucket prod-elife-epp-pdf
terraform import module.epp.aws_s3_bucket.meca_bucket prod-elife-epp-meca
```
