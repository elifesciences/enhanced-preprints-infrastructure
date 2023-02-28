terraform {
    backend "s3" {
        region  = "us-east-1"
        bucket  = "elife-epp-infrastructure"
        key     = "epp--staging.tfstate"
    }
}
