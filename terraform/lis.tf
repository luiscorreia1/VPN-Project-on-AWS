resource "aws_instance" "lis-srv" {
  ami                                  = var.lis-srv
  instance_type                        = "t2.small"
  key_name                             = aws_key_pair.lis.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.lis-public1.id
  }
  tags                                 = {
    "Name" = "lis-srv"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for lis"
    }
    volume_size           = 30
    volume_type           = "gp2"
  }
  user_data = data.template_file.winsrv.rendered
}

resource "aws_network_interface" "lis-private1" {
  private_ips         = ["192.168.0.80"]
  security_groups    = [
    aws_security_group.lis-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.lis-subnet-private1.id
  tags                                 = {
    "Name" = "lis private1 interface"
  }
  attachment {
    device_index  = 1
    instance      = aws_instance.lis-srv.id
  }
}

resource "aws_network_interface" "lis-private2" {
  private_ips         = ["192.168.0.130"]
  security_groups    = [
    aws_security_group.lis-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.lis-subnet-private2.id
  tags                                 = {
    "Name" = "lis private1 interface"
  }
  attachment {
    device_index  = 1
    instance      = aws_instance.lis-srv.id
  }
}

resource "aws_network_interface" "lis-public1" {
  private_ips         = ["192.168.0.10"]
  security_groups    = [
    aws_security_group.lis-default.id
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.lis-subnet-public1.id
  tags                                 = {
    "Name" = "lis public interface"
  }
}

resource "aws_eip" "lis-public-ip" {
  vpc                       = true
  network_interface         = aws_network_interface.lis-public1.id
  tags                                 = {
    "Name" = "lis public IP"
  }
  depends_on = [
    aws_instance.lis-srv
  ]
}