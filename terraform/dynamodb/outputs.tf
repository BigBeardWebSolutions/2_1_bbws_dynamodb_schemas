output "tenants_table_name" {
  description = "Name of the tenants table"
  value       = aws_dynamodb_table.tenants.name
}

output "tenants_table_arn" {
  description = "ARN of the tenants table"
  value       = aws_dynamodb_table.tenants.arn
}

output "products_table_name" {
  description = "Name of the products table"
  value       = aws_dynamodb_table.products.name
}

output "products_table_arn" {
  description = "ARN of the products table"
  value       = aws_dynamodb_table.products.arn
}

output "campaigns_table_name" {
  description = "Name of the campaigns table"
  value       = aws_dynamodb_table.campaigns.name
}

output "campaigns_table_arn" {
  description = "ARN of the campaigns table"
  value       = aws_dynamodb_table.campaigns.arn
}

output "table_names" {
  description = "List of all created table names"
  value = [
    aws_dynamodb_table.tenants.name,
    aws_dynamodb_table.products.name,
    aws_dynamodb_table.campaigns.name
  ]
}
