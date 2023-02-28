module "epp-storage" {
  source                = "../../modules/epp-storage"

  account_id            = 512686554592
  env                   = "staging"
  irsa_oidc_provider    = "oidc.eks.us-east-1.amazonaws.com/id/0108D0073AFB87B6669E378F0A9CFB76"
  irsa_namespace        = "epp--staging"
  irsa_service_account  = "default"
}
