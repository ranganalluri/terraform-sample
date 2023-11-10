output "rg_names" {
  value = azurerm_resource_group.rg_groups[*].name
}

output "rg_location" {
  value = azurerm_resource_group.rg_groups[0].location
}