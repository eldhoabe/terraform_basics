output "fully_qualified_domain_name" {
  value = azurerm_sql_server.test.fully_qualified_domain_name
}

output "dbname" {
  value = azurerm_sql_database.test.name
}

output "dbuser" {
  value = azurerm_sql_server.test.administrator_login
}

output "dbpwd" {
  value = azurerm_sql_server.test.administrator_login_password
}



