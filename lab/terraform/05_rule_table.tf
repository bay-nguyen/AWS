#Create route table on public subnet

resource "aws_route_table" "dsia_rule_table_public" {
	vpc_id				= aws_vpc.dsia_vpc.id
	tags = {
		Name 			= "dsia_rtb_public"
	}
}

resource "aws_route_table_association" "rtb_public" {
    route_table_id = aws_route_table.dsia_rule_table_public.id
    subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route" "dsia_route_igw" {
    route_table_id         = aws_route_table.dsia_rule_table_public.id
    destination_cidr_block = "0.0.0.0/0"
	gateway_id			   = aws_internet_gateway.dsia_gw.id 
}

#Create route table on private subnet

resource "aws_route_table" "dsia_rule_table_private" {
	vpc_id		= aws_vpc.dsia_vpc.id
	tags = {
		Name 	= "dsia_rtb_private"
	}
}

resource "aws_route_table_association" "rtb_private" {
    route_table_id = aws_route_table.dsia_rule_table_private.id
    subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route" "dsia_route_ngw" {
    route_table_id         = aws_route_table.dsia_rule_table_private.id
    destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id		   = aws_nat_gateway.public_nat_gw.id
}
