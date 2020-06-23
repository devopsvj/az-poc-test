provider "azurerm" {
    version = "~> 1.19"
}

locals {
    tags = {
        "appid"       = "1001"
        "managed"     = "terraformed"
        "owner"       = "XXXXX@XXXX.XXX"
        "environment" = "learning"
    }
}

resource "azurerm_resource_group" "main" {
    name     = "azure-devopsvj-sql-rg"
    location = "East US"
    tags     = local.tags
}

resource "azurerm_sql_server" "main" {
    name                         = "azuredevopsvjsql"
    resource_group_name          = azurerm_resource_group.main.name
    location                     = azurerm_resource_group.main.location
    version                      = "12.0"
    administrator_login          = "4dm1n157r470r"
    administrator_login_password = "We1CoMe2020!azure"
    tags                         = local.tags
}

resource "azurerm_sql_firewall_rule" "main" {
  name                = "AlllowAzureServices"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "main" {
  name                             = "azdevopsvjdb"
  resource_group_name              = azurerm_resource_group.main.name
  location                         = azurerm_resource_group.main.location
  server_name                      = azurerm_sql_server.main.name
  edition                          = "Standard"
  requested_service_objective_name = "S0"
  tags                             = local.tags
}
