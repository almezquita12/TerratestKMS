terraform {
  required_version = "~> 0.12"
}


locals{
  naming = join("",[var.entity,var.environment,var.geo_region,"kms",var.app_name,var.function,var.sequence])
  policy = <<EOF

{
"Version": "2012-10-17",

"Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.${var.aws_region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:*"
                }
            }
        }
    ]


}
EOF

}  

data "aws_caller_identity" "current" {}


resource "aws_ssm_parameter" "kms_key" {
  name  = join("",["/wkl/kms/",local.naming])
  type  = "String"
  value = var.external == true ? aws_kms_external_key.my_external_key[0].arn : aws_kms_key.my_key[0].arn
}

resource "aws_kms_key""my_key"{
    count                     =  var.external == true ? 0 : 1
    description               =  var.resource_description
    key_usage                 =  var.key_usage
    customer_master_key_spec  =  var.symmetric == true? "SYMMETRIC_DEFAULT" : "RSA_2048"
    policy                    =  local.policy
    deletion_window_in_days   =  30
    is_enabled                =  var.is_enabled
    enable_key_rotation       =  false
    tags                      =  {
        "Product"             =  var.product
        "Cost Center"         =  var.cost_center
        "Channel"             =  var.channel
        "Description"         =  var.description
        "Tracking Code"       =  var.tracking_code
        "CIA"                 =  var.cia
    }
}

resource "aws_kms_external_key" "my_external_key" {
    count                     =  var.external == true ? 1 : 0
    description               =  var.resource_description
    policy                    =  local.policy
    deletion_window_in_days   =  30
    key_material_base64       =  var.key_material
    enabled                   =  var.is_enabled
    valid_to                  =  var.valid_to
    tags                      =  {
      "Product"               =  var.product
      "Cost Center"           =  var.cost_center
      "Channel"               =  var.channel
      "Description"           =  var.description
      "Tracking Code"         =  var.tracking_code
      "CIA"                   =  var.cia
    }
}

resource "aws_kms_alias""my_key_alias" {
    count                     =  var.external == true ? 0 : 1
    depends_on                = [aws_kms_key.my_key]
    name                      =  join("",["alias/",local.naming])
    target_key_id             =  aws_kms_key.my_key[0].key_id
}

resource "aws_kms_alias""my_external_key_alias" {
    count                     =  var.external == true ? 1 : 0
    depends_on                = [aws_kms_external_key.my_external_key]
    name                      =  join("",["alias/",local.naming])
    target_key_id             =  aws_kms_external_key.my_external_key[0].id
}
