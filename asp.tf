   locals {
 
      ase_name = "core-compute-${var.env}"

     // I2 in prod like env, I1 everywhere else
     sku_size = "${var.env == "prod" || var.env == "sprod" || var.env == "aat" ? "I2" : "I1"}"
    }
 
 
 
   module "appServicePlan" {
 
      source = "git@github.com:hmcts/cnp-module-app-service-plan?ref=master"
      location = "UK South"
      env = "${var.env}"
      resource_group_name = "${azurerm_resource_group.rg.name}"
      asp_capacity = "${var.asp_capacity}"
      asp_sku_size = "${local.sku_size}"  // Specifies the plan's instance size (set to "I1")
      asp_name = "${var.product}"
      ase_name = "${local.ase_name}"
      tag_list = "${local.tags}"
}
