resource "aws_security_group" "lis-default" {
  description = "lis default security group"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "192.168.0.0/16",
        "172.16.0.0/12",
        "10.0.0.0/8",
        aws_eip.pdl-public-ip.public_ip,
      ]
      description      = "RFC 1918"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
  ]
  name        = "lis default"
  tags        = {
    "Name" = "lis"
  }
  vpc_id      = aws_vpc.lis-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "home" {
  cidr_ipv4              = "1.1.1.1/32"
  description            = "home"
  ip_protocol            = "-1"
  security_group_id      = aws_security_group.lis-default.id
  tags                   = {
    "Name" = "home"
  }
  depends_on = [
    aws_security_group.lis-default
  ]
}