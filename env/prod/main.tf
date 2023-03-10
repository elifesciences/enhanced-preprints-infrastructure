module "epp" {
  source                = "../../modules/epp"

  account_id            = 512686554592
  env                   = "prod"
  irsa_oidc_provider    = "oidc.eks.us-east-1.amazonaws.com/id/0108D0073AFB87B6669E378F0A9CFB76"
  irsa_namespace        = "epp--prod"
  irsa_service_account  = "default"
  biorxiv_role_arn      = "arn:aws:iam::512686554592:role/access-biorxiv-xml"
}
