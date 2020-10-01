output "kms_id" {
  description = "ID of the KMS created"
  value       = var.external == true ? aws_kms_external_key.my_external_key[0].id : aws_kms_key.my_key[0].key_id
}

output "kms_arn" {
  description = "arn of the KMS created"
  value       = var.external == true ? aws_kms_external_key.my_external_key[0].arn : aws_kms_key.my_key[0].arn
}

output "kms_ssm_name" {
  description = "Name of SSM parameter store name."
  value       = join("",["/wkl/kms/",local.naming])
  }
