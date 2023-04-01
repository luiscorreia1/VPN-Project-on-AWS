resource "aws_instance" "pdl-srv" {
  ami                                  = var.pdl-ami
  instance_type                        = "t2.small"
  key_name                             = aws_key_pair.pdl.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.pdl-public1.id
  }
  tags                                 = {
    "Name" = "pdl-srv"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for pdl"
    }
    volume_size           = 30
    volume_type           = "gp2"
  }
  user_data = data.template_cloudinit_config.config-pdl.rendered
}

resource "aws_network_interface" "pdl-private1" {
  private_ips         = ["172.21.1.100"]
  security_groups    = [
    aws_security_group.pdl-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.pdl-subnet-private1.id
  tags                                 = {
    "Name" = "pdl private1 interface"
  }
  attachment {
    device_index  = 1
    instance      = aws_instance.pdl-srv.id
  }
}

resource "aws_network_interface" "pdl-private2" {
  private_ips         = ["172.21.2.100"]
  security_groups    = [
    aws_security_group.pdl-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.pdl-subnet-private2.id
  tags                                 = {
    "Name" = "pdl private1 interface"
  }
  attachment {
    device_index  = 1
    instance      = aws_instance.pdl-srv.id
  }
}

resource "aws_network_interface" "pdl-public1" {
  private_ips        = ["172.21.1.100"]
  security_groups    = [
    aws_security_group.pdl-default.id
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.pdl-subnet-public1.id
  tags                                 = {
    "Name" = "pdl public interface"
  }
}

resource "aws_eip" "pdl-public-ip" {
  vpc                       = true
  network_interface         = aws_network_interface.pdl-public1.id
  tags                                 = {
    "Name" = "pdl public IP"
  }
}