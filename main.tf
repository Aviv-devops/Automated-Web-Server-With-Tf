# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create Security Group
resource "aws_security_group" "security_g_terraform" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-g-terraform"
  }
}

# Create EC2 Instance
resource "aws_instance" "nginx" {
  ami             = "ami-03ed1381c73a5660e" # Update this with a valid AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public.id
  vpc_security_group_ids = ["${aws_security_group.security_g_terraform.id}"]
  user_data = file("userdata.sh")

  tags = {
    Name = "ec2-terraform-nginx-project"
  }
}

#output public ipv4 of the instance - the url of the web page
output "instance_public_url" {
  description = "The public URL of the instance"
  value       = "http://${aws_instance.nginx.public_dns}"
}