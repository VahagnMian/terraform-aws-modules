variable "name" {
  type    = string
  default = "api-gw"
}

variable "endpoint_config_type" {
  type    = string
  default = "REGIONAL"
}

variable "stage_name" {
  type    = string
  default = "api-stage"
}

variable "rest_api_id" {
  type    = string
  default = ""
}

variable "open_api_path" {
  type    = string
  default = ""
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key. `pgp_key` is required when `create_iam_user_login_profile` is set to `true`"
  type        = string
  default     = ""
}

variable "iam_username" {
  description = "username of newly created IAM user"
  type        = string
  default     = "api-gw-user"
}

variable "policy_name" {
  description = "API Gateway policy name"
  type        = string
  default     = "api-gw-policy"
}
