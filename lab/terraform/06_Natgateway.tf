# Create natgateway

resource "aws_nat_gateway" "public_nat_gw" {


  subnet_id     = aws_subnet.public_subnet_1a.id
  connectivity_type  = "public"
  allocation_id = "eipalloc-051a4078370b5cfd9"

  tags = {
    Name = "public_nat_gw"
  }
  
}
