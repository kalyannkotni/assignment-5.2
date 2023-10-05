# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "${var.vpc-dev}"
  tags = {
    "Name" = "${var.vpc-tag-name}"
  }
}

# Resource-2: Create Subnets
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "${var.subnet-dev}"
  availability_zone = "${var.subnet-region}"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.subnet-tag-name}"
  }
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "${var.igw-tag-name}"
  }
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "${var.rt-tag-name}"
  }
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-dev-public-route" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  destination_cidr_block = "${var.route}"
  gateway_id = aws_internet_gateway.vpc-dev-igw.id
}


# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-dev-public-route-table-associate" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
}
