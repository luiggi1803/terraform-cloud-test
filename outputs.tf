output "deployment_stage" {
  description = "Stage al que se desplegará la infraestructura"
  value = {
    vpc_id_ohio = aws_vpc.vpc_ohio.id
    environment = var.environment
    stage_code  = local.deployment_stage
    region      = var.aws_region
    region_code = local.region_prefix
    use_floci   = var.use_floci
  }
}

output "ec2_public_ip" {
  description = "Public IP of the public instance"
  //quiero que se muestre el nombre de la instancia y el public ip
  value = [for inst in aws_instance.public_instance : {
    name = inst.tags["Name"]
    public_ip = inst.public_ip
  }]
}
