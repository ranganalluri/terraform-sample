resource "azurerm_resource_group" "rg_groups" {
  count    = var.rgcount
  tags     = {Name="test"}
  name     = "${var.rg_name-startswith}${count.index}"
  location = "westus2"
}
