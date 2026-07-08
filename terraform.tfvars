use_floci      = false
aws_region     = "us-east-2"
environment    = "dev"
ohio_cidr      = "10.10.0.0/16"
floci_endpoint = "http://localhost:4566"
# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"
subnets = ["10.10.0.0/24", "10.10.1.0/24"]
sg_ingress_cidr = "0.0.0.0/0"
ec2_specs = {
  instance_type = "t3.micro"
  ami = "ami-0772d6acfbccb1275"
}
enable_monitoring = false

ingress_ports_list = [22, 80, 443]