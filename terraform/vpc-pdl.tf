resource "aws_vpc" "pdl-vpc" {
  cidr_block                           = "172.21.0.0/16"
  tags                                 = {
    "Name" = "pdl-vpc"
  }
}

resource "aws_subnet" "pdl-subnet-private1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "172.21.1.0/24"
  tags                                           = {
    "Name" = "pdl-subnet-private1"
  }
  vpc_id                                         = aws_vpc.pdl-vpc.id
}

resource "aws_subnet" "pdl-subnet-private2" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "172.21.2.0/24"
  tags                                           = {
    "Name" = "pdl-subnet-private2"
  }
  vpc_id                                         = aws_vpc.pdl-vpc.id
}

resource "aws_subnet" "pdl-subnet-public1" {
  availability_zone                              = var.avail_zone
  cidr_block                                     = "172.21.0.0/24"
  tags                                           = {
    "Name" = "pdl-subnet-public1"
  }
  vpc_id                                         = aws_vpc.pdl-vpc.id
}

resource "aws_internet_gateway" "pdl-igw" {
  tags     = {
    "Name" = "pdl-igw"
  }
  vpc_id   = aws_vpc.pdl-vpc.id
}

resource "aws_route_table" "pdl-rt-private1" {
  tags             = {
    "Name" = "pdl-rtb-private1"
  }
  vpc_id           = aws_vpc.pdl-vpc.id
}

resource "aws_route_table" "pdl-rt-private2" {
  tags             = {
    "Name" = "pdl-rtb-private2"
  }
  vpc_id           = aws_vpc.pdl-vpc.id
}

resource "aws_route_table" "pdl-rt-public1" {
  vpc_id = aws_vpc.pdl-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pdl-igw.id
  }
  tags             = {
    "Name" = "pdl-rtb-public"
  }
}

resource "aws_route_table_association" "pdl-rta-private1" {
  route_table_id = aws_route_table.pdl-rt-private1.id
  subnet_id      = aws_subnet.pdl-subnet-private1.id
}

resource "aws_route_table_association" "pdl-rta-private2" {
  route_table_id = aws_route_table.pdl-rt-private2.id
  subnet_id      = aws_subnet.pdl-subnet-private2.id
}

resource "aws_route_table_association" "pdl-rta-public1" {
  route_table_id = aws_route_table.lis-rt-public1.id
  subnet_id      = aws_subnet.pdl-subnet-public1.id
}

resource "aws_vpc_endpoint" "pdl-vpce-s3" {
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
    aws_route_table.pdl-rt-private1.id,
    aws_route_table.pdl-rt-private2.id,
  ]
  service_name          = var.vpc_ep_svc_name
  tags                  = {
    "Name" = "pdl-vpce-s3"
  }
  vpc_endpoint_type     = "Gateway"
  vpc_id                = aws_vpc.pdl-vpc.id
}

resource "aws_key_pair" "pdl" {
  key_name   = "pdl"
  public_key = var.public_key
}