# main vpc and components

# Main VPC

resource "aws_vpc" "web-sheila-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "web-sheila-VPC"
  }
}


# PUBLIC SUBNET1

resource "aws_subnet" "web1-sheila-PUB1-SUB1" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.41.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "web1-sheila-PUB1-SUB1"
  }
}

# PUBLIC SUBNET2

resource "aws_subnet" "web2-sheila-PUB2-SUB2" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.42.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "web2-sheila-PUB2-SUB2"
  }
}


# PRIVATE SUBNET1

resource "aws_subnet" "application1-sheila-Priv1-SUB3" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.43.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "application1-sheila-Priv1-SUB3"
  }
}

# PRIVATE SUBNET2

resource "aws_subnet" "application2-sheila-Priv2-SUB4" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.44.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "application2-sheila-Priv2-SUB4"
  }
}

# PRIVATE SUBNET3(RDS)

resource "aws_subnet" "database1-sheila-Priv3-SUB5" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.45.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "database1-sheila-Priv3-SUB5"
  }
}

# PRIVATE SUBNET4(RDS)

resource "aws_subnet" "database2-sheila-Priv4-SUB6" {
  vpc_id     = aws_vpc.web-sheila-VPC.id
  cidr_block = "10.0.46.0/24"
availability_zone = "us-east-1f"

  tags = {
    Name = "database2-sheila-Priv4-SUB6"
  }
}

# PUBLIC ROUTE TABLE

resource "aws_route_table" "web-sheila-PUBLIC-RT" {
  vpc_id = aws_vpc.web-sheila-VPC.id

  tags = {
    Name = "web-sheila-PUBLIC-RT"
  }
}

# PRIVATE ROUTE TABLE

resource "aws_route_table" "rds-sheila-PRIVATE-RT" {
  vpc_id = aws_vpc.web-sheila-VPC.id

  tags = {
    Name = "rds-sheila-PRIVATE-RT"
  }
}

# PUBLIC SUBNET1 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "web-sheila-PUBSUB1-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.web1-sheila-PUB1-SUB1.id
  route_table_id = aws_route_table.web-sheila-PUBLIC-RT.id
}

# PUBLIC SUBNET2 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "web-sheila-PUBSUB2-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.web2-sheila-PUB2-SUB2.id
  route_table_id = aws_route_table.web-sheila-PUBLIC-RT.id
}


# PRIVATE APPLICATION SUBNET ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "app1-sheila-PRIVSUB-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.application1-sheila-Priv1-SUB3.id
  route_table_id = aws_route_table.rds-sheila-PRIVATE-RT.id
}


# PRIVATE APPLICATION2 SUBNET ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "app2-sheila-PRIVSUB-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.application2-sheila-Priv2-SUB4.id
  route_table_id = aws_route_table.rds-sheila-PRIVATE-RT.id
}

# PRIVATE DATABASE1 SUBNET ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "rds1-sheila-PRIVSUB-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.database1-sheila-Priv3-SUB5.id
  route_table_id = aws_route_table.rds-sheila-PRIVATE-RT.id
}

# PRIVATE DATABASE2 SUBNET ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "rds2-sheila-PRIVSUB-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.database2-sheila-Priv4-SUB6.id
  route_table_id = aws_route_table.rds-sheila-PRIVATE-RT.id
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "sheila-igw" {
  vpc_id = aws_vpc.web-sheila-VPC.id

  tags = {
    Name = "sheila-igw"
  }
}


# IGW ASSOCIATION WITH ROUTE TABLE

resource "aws_route" "Assoc-public-RT" {
  route_table_id         = aws_route_table.web-sheila-PUBLIC-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sheila-igw.id
}


# SECURITY GROUP FOR VPC
# terraform aws create security GROUP

resource "aws_security_group" "sheila-vpc-security-group" {
  name        = "sheila-vpc-security-group"
  description = "Allow HTTP access or port 80"
  vpc_id      = aws_vpc.web-sheila-VPC.id


  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sheila-vpc-security-group"
  }
}