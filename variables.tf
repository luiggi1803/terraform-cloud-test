variable "use_floci" {
  type        = bool
  description = "true = Floci local (localhost:4566), false = AWS real (default)"
}

variable "aws_region" {
  type        = string
  description = "Región AWS (us-east-1 → UE1, us-east-2 → OH2)"

  validation {
    condition     = contains(["us-east-1", "us-east-2"], var.aws_region)
    error_message = "aws_region debe ser us-east-1 o us-east-2."
  }
}

variable "environment" {
  type        = string
  description = "Stage de despliegue: dev → DESA, test → TEST, prod → PROD"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment debe ser dev, test o prod."
  }
}

variable "floci_endpoint" {
  type        = string
  description = "URL base de Floci"
}

variable "ohio_cidr" {
  type        = string
  description = "CIDR Ohio"
  sensitive   = false
}

# variable "public_subnet" {
#   type        = string
#   description = "CIDR Public Subnet"
# }

# variable "private_subnet" {
#   type        = string
#   description = "CIDR Private Subnet"
# }

variable "subnets" {
  type        = list(string)
  description = "List of CIDR subnets"
}

variable "sg_ingress_cidr" {
  description = "CIDR for the ingress security group"
  type        = string
}

variable "ec2_specs" {
  description = "Specifications for the EC2 instance"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable monitoring for the EC2 instance"
  type        = bool
}

variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}