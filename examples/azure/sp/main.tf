module "sp" {
  source = "../../../modules/azure/sp"

  prefix        = var.prefix
  label         = var.label
  role          = var.role
  scopes        = var.scopes
  rotation_days = var.rotation_days
  tags          = var.tags
}
