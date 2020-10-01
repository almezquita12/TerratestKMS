//   PROVIDER
variable "aws_region" {
  description = "(Required) Region to deploy the resources to"
  type        = string
}

// IAM POLICY DOCUMENT
//variable "kms_policy_arn"{
//  description = "(Required) ARN of the policy that the KMS is going to have attached"
//  type = string
//}

//   RESOURCE AWS_KMS_KEY
variable "resource_description" {
  description = "(Required) Enter the description of the KMS."
  type        = string
}


variable "key_usage" {
  description = "(Required) [ENCRYPT_DECRYPT or SIGN_VERIFY]"
  type        = string

}

variable "symmetric" {
  description = "(Required) If true, KMS will be symmetric, otherwise it will be (RSA_2048)"
  type        = bool

}

variable "is_enabled" {
  description = "(Optional) Specifies whether the key is enabled."
  type        = bool
  default     = true
}

// kMS EXTERNAL KEY
variable "external"{
  description = "(Required) If true, CMK material will be provided by the user."
  type = bool
}

variable "key_material" {
  description = "(Optional) Specifies the material used by the algorithm to encrypt the data. Gives an extra level of security because otherwise is AWS the one who manage how data is encrypted"
  type        = string
}

variable "valid_to" {
  description = "(Optional) Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ)"
  type        = string
}

//   RESOURCE AWS_KMS_ALIAS


// TAGGING VARIABLES

variable "product" {
  description = "(Required) The product tag will indicate the product to which the associated resource belongs to."
  type        = string
}

variable "cost_center" {
  description = "(Required) This tag will report the cost center of the resource."
  type        = string
}

variable "channel" {
  description = "(Optional) This tag will indicate the distribution channel to which the associated resource belongs to."
  type        = string
}

variable "description" {
  description = "(Required) This tag will allow the resource operator to provide additional context information"
  type        = string
}

variable "tracking_code" {
  description = "(Required) Its value will be provided by the staff member deploying the resource during deployment."
  type        = string
}

variable "cia" {
  description = "(Required) CIA(Confidentiality[A,B,C] Integrity[L,M,H] Availability[L,M,C])"
  type        = string
}

//NAMING VARIABLES

variable "entity" {
  description = "(Required) Santander entity code. Used for Naming. (3 characters) "
  type        = string
}

variable "environment" {
  description = "(Required) Santander environment code. Used for Naming. (2 characters) "
  type        = string
}

variable "geo_region" {
  description = "(Required) AWS region where is going to be the resource. Used for Naming. (3 characters) "
  type        = string
}

variable "app_name" {
  description = "(Required) App acronym of the resource. Used for Naming. (6 characters) "
  type        = string
}

variable "function" {
  description = "(Required) App function of the resource. Used for Naming. (4 characters) "
  type        = string
}

variable "sequence" {
  description = "(Required) Secuence number of the resource. Used for Naming. (2 characters) "
  type        = string
}
