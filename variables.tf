# general variable
variable "main_project_tag" {
  description = "Tag that will be attached to all resources."
  type        = string
  default     = "General"
}

variable "aws_default_region" {
  description = "The default region that all resources will be deployed into."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "Cidr block for the VPC."
  type        = string
  default     = "10.255.0.0/22"
}
variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access ec2 instances.  Defaults to Everywhere."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_public_subnet_count" {
  description = "The number of public subnets to create.  Cannot exceed the number of AZs in your selected region.  2 is more than enough."
  type        = number
  default     = 2
}

variable "vpc_tags" {
  description = "Additional tags to add to the VPC and its resources."
  type        = map(string)
  default     = {}
}

variable "server_desired_count" {
  description = "The desired number of servers"
  type        = number
  default     = 2
}

variable "server_min_count" {
  description = "The minimum number of servers."
  type        = number
  default     = 2
}

variable "server_max_count" {
  description = "The maximum number of servers."
  type        = number
  default     = 3
}