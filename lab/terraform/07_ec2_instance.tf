# Bastion Server public instance 1a

resource "aws_instance" "ec2_instance_public_1a"{
  ami                         = "ami-0f9fe1d9214628296"
  instance_type               = "t3.micro"
  availability_zone           = "ap-northeast-1a"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  key_name                    = "my-key"
  security_groups             = [aws_security_group.dsia_sg.id]
  associate_public_ip_address = "true"
  tags = {
    Name = "ec2_instance_public_1a"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

}

# Private Instance 1a

resource "aws_instance" "ec2_instance_private_1a"{
  ami                         = "ami-0f9fe1d9214628296"
  instance_type               = "t3.micro"
  availability_zone           = "ap-northeast-1a"
  subnet_id                   = aws_subnet.private_subnet_1a.id
  key_name                    = "my-key"
  security_groups              = [aws_security_group.dsia_sg.id]
  tags = {
    Name = "ec2_instance_private_1a"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

# Private Instance 1c

resource "aws_instance" "ec2_instance_private_1c"{
  ami                         = "ami-0f9fe1d9214628296"
  instance_type               = "t3.micro"
  availability_zone           = "ap-northeast-1c"
  subnet_id                   = aws_subnet.private_subnet_1c.id
  key_name                    = "my-key"
  security_groups              = [aws_security_group.dsia_sg.id]
  tags = {
    Name = "ec2_instance_private_1c"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}