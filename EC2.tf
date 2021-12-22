# WEBSERVER1 instance

resource "aws_instance" "webserver1" {
	ami = "ami-0ed9277fb7eb570c9"
	instance_type = "t2.micro"
    subnet_id = aws_subnet.web1-sheila-PUB1-SUB1.id
    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.sheila-vpc-security-group.id]

user_data = <<EOF
#!/bin/bash 
# Please make sure to launch Amazon Linux 2 
yum update -y 
yum install -y httpd 
systemctl start httpd 
systemctl enable httpd

EOF
}

# WEBSERVER 2 instance

resource "aws_instance" "webserver2" {
	ami = "ami-0ed9277fb7eb570c9"
	instance_type = "t2.micro"
    subnet_id = aws_subnet.web2-sheila-PUB2-SUB2.id
    availability_zone = "us-east-1b"
    vpc_security_group_ids = [aws_security_group.sheila-vpc-security-group.id]

user_data = <<EOF
#!/bin/bash 
# Please make sure to launch Amazon Linux 2 
yum update -y 
yum install -y httpd 
systemctl start httpd 
systemctl enable httpd

EOF
}
