output "db_password" {
  value = module.database.config.password
  sensitive = true
}

output "db_dns" {
  value = module.database.config.hostname
  sensitive = true
}

output "s3_static_url" {
  value = module.s3.s3_dns_name
}

output "vm_ip" {
  value = module.vm.lb_dns
}


# output "lambdas" {
#   value = module.lambdas.lambda
# }