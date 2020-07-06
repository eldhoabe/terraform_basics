provider "azurerm" {
  version = "=2.0.0"
  features {}
}



resource "azurerm_resource_group" "rg" {
    name     = "myTFResourceGroupfromfile"
    location = "centralus"
    
    tags = {
        Environment = "Terraform Getting Started"
        Team = "Tf"   
    }
}

# to allow remote key
terraform {
  backend "azurerm" {
    resource_group_name   = "myTFResourceGroup"
    storage_account_name  = "mytfstorageeldho"
    container_name        = "mytfcontainereldho"
    key                   = "mytfkey"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
  
  tags = {
        Environment = "Terraform Getting Started"
        Team = "Tf"   
    }
  
}

resource "azurerm_app_service" "example" {
  name                = "myterraformapplication24"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

 connection_string {
   name  = "Database"
   type  = "SQLServer"
  #  value = "Server=tcp:${azurerm_sql_server.test.fully_qualified_domain_name} Database=${azurerm_sql_database.test.name};User ID=${azurerm_sql_server.test.administrator_login};Password=${azurerm_sql_server.test.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
   value = "Server=tcp:${module.db.fully_qualified_domain_name} Database=${module.db.dbname};User ID=${module.db.dbuser};Password=${module.db.dbpwd};Trusted_Connection=False;Encrypt=True;"
  }
}

# To create sql database server, db and add firewall
module "db" {
  source = "../modules/db"
  resourcegroup_name = azurerm_resource_group.rg.name
  resourcegroup_location = azurerm_resource_group.rg.location
  environment = var.environment
  teams = var.teams
  
}

