/*
resource "azurerm_automation_account" "aa" {
  name                = "${var.app_id}-aa"
  location            = "${data.consul_keys.keys.var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku {
        name = "Free"
  }
}

resource "azurerm_automation_schedule" "startup_schedule" {
  name                = "${var.app_id}-startup-schedule"
  resource_group_name = "${var.resource_group_name}"
  account_name        = "${azurerm_automation_account.aa.name}"
  frequency           = "Day"
  timezone            = "A.U.S. Eastern Standard Time"
  start_time          = "2014-04-15T18:00:15+02:00"
  description         = "This is an example schedule"
} */