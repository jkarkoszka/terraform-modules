module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
  tags     = var.tags
}
