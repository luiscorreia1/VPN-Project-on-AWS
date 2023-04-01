resource "aws_security_group" "pdl-default" {
  description = "pdl default security group"
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
        aws_eip.lis-public-ip.public_ip,
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
  name        = "pdl default"
  tags        = {
    "Name" = "pdl"
  }
  vpc_id      = aws_vpc.pdl-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "home-pdl" {
  cidr_ipv4              = "1.1.1.1/32"
  description            = "home"
  ip_protocol            = "-1"
  security_group_id      = aws_security_group.pdl-default.id
  tags                   = {
    "Name" = "home"
  }
}