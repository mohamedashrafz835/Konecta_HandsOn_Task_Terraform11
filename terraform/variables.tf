variable "vpc_cidr" {}
variable "public1_cidr" {}
variable "public2_cidr" {}
variable "private1_cidr" {}
variable "private2_cidr" {}
variable "az1" {}
variable "az2" {}
variable "nat1_eip" {}
variable "nat2_eip" {}
variable "project_name" {}
variable "tags" {
  type = map(string)
}
variable "cf_templates_bucket_name" {}
variable "documents_bucket_name" {}
variable "owner_id" {}
variable "tags" {
  type = map(string)
}

