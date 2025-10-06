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
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_container_insights" {
  description = "Enable or disable ECS container insights"
  type        = string
}

variable "ecs_tags" {
  description = "Tags for the ECS cluster"
  type        = map(string)
}


variable "ecr_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "The tag mutability for the ECR repository"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_encryption_type" {
  description = "Encryption type for the ECR repository"
  type        = string
  default     = "AES256"
}

variable "ecr_scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
  default     = false
}

variable "ecr_tags" {
  description = "Tags for the ECR repository"
  type        = map(string)
  default     = {}
}

variable "sg_name" {
  description = "Security Group name"
  type        = string
}

variable "sg_description" {
  description = "Security Group description"
  type        = string
}

variable "sg_vpc_id" {
  description = "VPC ID where Security Group will be created"
  type        = string
}

variable "sg_ingress_rules" {
  description = "Ingress rules for the Security Group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_egress_rules" {
  description = "Egress rules for the Security Group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "sg_tags" {
  description = "Tags for the Security Group"
  type        = map(string)
}

