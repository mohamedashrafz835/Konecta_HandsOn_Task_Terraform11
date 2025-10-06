variable "name" {
  description = "The name of the Security Group"
  type        = string
}

variable "description" {
  description = "Description of the Security Group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where this Security Group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the Security Group"
  type        = map(string)
  default     = {}
}
