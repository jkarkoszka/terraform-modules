module "kind_cluster" {
  source = "../../../modules/local/kind_cluster"

  prefix      = var.prefix
  label       = var.label
  k8s_version = var.k8s_version
}
