resource "azurerm_sql_server" "test" {
  name                         = "terraform-sqlserver"
  resource_group_name          = var.resourcegroup_name
  location                     = var.resourcegroup_location
  version                      = "12.0"
  administrator_login          = "eldhoabe"
  administrator_login_password = "mypassword-123"
}

resource "azurerm_sql_database" "test" {
  name                = "terraform-sqldatabase"
  resource_group_name = var.resourcegroup_name
  location            = var.resourcegroup_location
  server_name         = azurerm_sql_server.test.name

  tags = {
        Environment = var.environment
        Team = var.teams
    }
}

# To allow azure services to connect with sql server
resource "azurerm_sql_firewall_rule" "example" {
  name                = "allowazureapptoconnect"
  resource_group_name = var.resourcegroup_name
  server_name         = azurerm_sql_server.test.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}