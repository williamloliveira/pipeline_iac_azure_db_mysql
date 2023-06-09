resource "azurerm_mysql_server" "mysql_server" {
  name                = "mysqlserver-${var.nome_sistema}-${local.ambiente}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = local.server_sku_name

  storage_mb                   = var.db_storage_max_size_mb
  backup_retention_days        = var.dias_retencao_backup
  geo_redundant_backup_enabled = local.reundancia_regiao_backup
  auto_grow_enabled            = local.db_storage_auto_grow

  administrator_login          = var.admin_user_login
  administrator_login_password = var.admin_user_passwd
  version                      = var.versao_mysql
  ssl_enforcement_enabled      = true

  tags = merge(local.tags)
}

resource "azurerm_mysql_database" "mysql_database" {
  name                = "mysqldb-${var.nome_sistema}-${local.ambiente}"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = var.db_charset
  collation           = var.db_collation
}