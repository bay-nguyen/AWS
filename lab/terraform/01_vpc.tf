#create vpc
resource "aws_vpc" "dsia_vpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = false
	tags = {
		Name = "dsia_vpc"
	}
}
