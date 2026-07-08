resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio_cidr

  tags = {
    Name = "vpc_ohio_${local.environment_code}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_ohio.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${local.environment_code}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_ohio.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "private_subnet_${local.environment_code}"
  }
  depends_on = [aws_subnet.public_subnet]
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_ohio.id
  tags = {
    Name = "internet_gateway_${local.environment_code}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_ohio.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public_route_table_${local.environment_code}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "sg_public_instance_${local.environment_code}"
  description = "Security group for the public instance"
  vpc_id      = aws_vpc.vpc_ohio.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      description = "Ingress ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_public_instance_${local.environment_code}"
  }
}
