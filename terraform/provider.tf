terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.56.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  #access_key = "xxxx"
  #secret_key = "xxxx"
  #token = "xxxx"

  profile = "default"
}

data "template_cloudinit_config" "config-lis" {
  gzip = false
  base64_encode = false

  part {
    filename = var.config-lis
    content_type = "text/x-shellscript"
    content = file(var.config-lis)
  }


}
