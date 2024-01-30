module "epp" {
  source                            = "../../modules/epp"

  account_id                        = 512686554592
  env                               = "biophysics-colab"
  irsa_oidc_provider                = "oidc.eks.us-east-1.amazonaws.com/id/0108D0073AFB87B6669E378F0A9CFB76"
  image_server_irsa_namespace       = "epp--biophysics-colab"
  image_server_irsa_service_account = "epp-image-server"
  epp_server_irsa_namespace         = "epp--biophysics-colab"
  epp_server_irsa_service_account   = "epp-server"
  production_team_group_name        = "elife-production"
}
