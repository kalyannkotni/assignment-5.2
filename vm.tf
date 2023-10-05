
# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami = "${var.ami}" # Amazon Linux
  instance_type = "${var.instanceType}"
  subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
  key_name = "pemkey"
  user_data = "${file("apache-install.sh")}"
  vpc_security_group_ids = [ aws_security_group.dev-vpc-sg.id ]
  tags = {
    "Name" = "${var.instanceName}"
  }
}

# Resource-9: Create Elastic IP
resource "aws_eip" "my-eip" {
    tags = {
    "Name" = "${var.eip}"
  }
}

# Resource-10: Elastic IP Allocation
resource "aws_eip_association" "my-eip-allocation" {
    instance_id = aws_instance.my-ec2-vm.id
    allocation_id = aws_eip.my-eip.id
}

