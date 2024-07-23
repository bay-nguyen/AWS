# Create internet gateway

resource "aws_internet_gateway" "dsia_gw" {
  vpc_id = aws_vpc.dsia_vpc.id

  tags = {
    Name = "dsia_gw"
  }
  
}