# Create public subnet 1a

resource "aws_subnet" "public_subnet_1a" {
	vpc_id = aws_vpc.dsia_vpc.id
	cidr_block = "10.0.10.0/24"
	availability_zone = "ap-northeast-1a"
	map_public_ip_on_launch = true
	
	tags = {
		Name = "pub_sub_1a"
	}
}

# Create public subnet 1c

resource "aws_subnet" "public_subnet_1c" {
	vpc_id = aws_vpc.dsia_vpc.id
	cidr_block = "10.0.12.0/24"
	availability_zone = "ap-northeast-1c"
	map_public_ip_on_launch = true
	
	tags = {
		Name = "pub_sub_1c"
	}
}

# Create private subnet 1a

resource "aws_subnet" "private_subnet_1a" {
	vpc_id = aws_vpc.dsia_vpc.id
	cidr_block = "10.0.20.0/24"
	availability_zone = "ap-northeast-1a"
	
	tags = {
		Name = "pri_sub_1a"
	}
}

# Create private subnet 1c

resource "aws_subnet" "private_subnet_1c" {
	vpc_id = aws_vpc.dsia_vpc.id
	cidr_block = "10.0.22.0/24"
	availability_zone = "ap-northeast-1c"
	
	tags = {
		Name = "pri_sub_1c"
	}
}