resource "aws_vpc" "lis-vpc" {
  cidr_block                           = "192.168.0.0/24"
  tags                                 = {
    "Name" = "lis-vpc"
  }
}

resource "aws_subnet" "lis-subnet-private1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "192.168.0.64/26"
  tags                                           = {
    "Name" = "lis-subnet-private1"
  }
  vpc_id                                         = aws_vpc.lis-vpc.id
}

resource "aws_subnet" "lis-subnet-private2" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "192.168.0.128/26"
  tags                                           = {
    "Name" = "lis-subnet-private2"
  }
  vpc_id                                         = aws_vpc.lis-vpc.id
}

resource "aws_subnet" "lis-subnet-public1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "192.168.0./26"
  tags                                           = {
    "Name" = "lis-subnet-public1"
  }
  vpc_id                                         = aws_vpc.lis-vpc.id
}

resource "aws_internet_gateway" "lis-igw" {
  tags     = {
    "Name" = "lis-igw"
  }
  vpc_id   = aws_vpc.lis-vpc.id
}

resource "aws_route_table" "lis-rt-private1" {
  tags             = {
    "Name" = "lis-rtb-private1"
  }
  vpc_id           = aws_vpc.lis-vpc.id
}

resource "aws_route_table" "lis-rt-private2" {
  tags             = {
    "Name" = "lis-rtb-private2"
  }
  vpc_id           = aws_vpc.lis-vpc.id
}

resource "aws_route_table" "lis-rt-public1" {
  vpc_id = aws_vpc.lis-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lis-igw.id
  }
  tags             = {
    "Name" = "lis-rtb-public"
  }
}

resource "aws_route_table_association" "lis-rta-private1" {
  route_table_id = aws_route_table.lis-rt-private1.id
  subnet_id      = aws_subnet.lis-subnet-private1.id
}

resource "aws_route_table_association" "lis-rta-private2" {
  route_table_id = aws_route_table.lis-rt-private2.id
  subnet_id      = aws_subnet.lis-subnet-private2.id
}

resource "aws_route_table_association" "lis-rta-public1" {
  route_table_id = aws_route_table.lis-rt-public1.id
  subnet_id      = aws_subnet.lis-subnet-public1.id
}

resource "aws_vpc_endpoint" "lis-vpce-s3" {
  policy                = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version   = "2008-10-17"
    }
  )
  route_table_ids       = [
    aws_route_table.lis-rt-private1.id,
    aws_route_table.lis-rt-private2.id,
  ]
  service_name          = var.vpc_ep_svc_name
  tags                  = {
    "Name" = "lis-vpce-s3"
  }
  vpc_endpoint_type     = "Gateway"
  vpc_id                = aws_vpc.lis-vpc.id
}

resource "aws_key_pair" "lis" {
  key_name   = "lis"
  public_key = var.public_key
}