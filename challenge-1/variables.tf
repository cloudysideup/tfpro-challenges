
variable "environment" {
  type = string
}

variable "s3_buckets" {
  type = set(string)
}

variable "s3_base_object" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "org-name" {
  type = string
}

variable "region" {
  type = string
}
