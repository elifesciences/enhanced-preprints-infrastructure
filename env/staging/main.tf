module "epp" {
  source                            = "../../modules/epp"

  account_id                        = 512686554592
  env                               = "staging"
  irsa_oidc_provider                = "oidc.eks.us-east-1.amazonaws.com/id/0108D0073AFB87B6669E378F0A9CFB76"
  image_server_irsa_namespace       = "epp--staging"
  image_server_irsa_service_account = "epp-image-server"
  epp_server_irsa_namespace         = "epp--staging"
  epp_server_irsa_service_account   = "epp-server"
  import_irsa_namespace             = "epp--staging"
  import_irsa_service_account       = "epp-import"
  biorxiv_role_arn                  = "arn:aws:iam::512686554592:role/access-biorxiv-xml"
  production_team_group_name        = "elife-production"
}
