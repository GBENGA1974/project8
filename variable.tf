# VARIABLE FILE

variable "subnets_cidrs_private" {
    description = "subnet CIDRs for private subnets (length must match configured availability_zones)"
    default = ["10.0.43.0/24", "10.0.44.0/24", "0.0.45.0/24", "10.0.46.0/24"]
    type = list(string)
}

variable "availability_zone" {
    description = "name of multiple availability_zones"
    default = ["us-east-1a", "us-east-2b", "us-east-2c"]
    type = list(string)
}

variable "private_app_subnet_ids" {
    description = "name of application private_subnet_ids"
    default = ["aws_subnet.application1-sheila-Priv1-SUB3.id", "aws_subnet.application2-sheila-Priv2-SUB4.id"]
    type = list(string)
}

variable "private_rds_subnet_ids" {
    description = "name of database private_subnet_ids"
    default = ["aws_subnet.database1-sheila-Priv3-SUB5.id", "aws_subnet.database2-sheila-Priv4-SUB6.id"]
    type = list(string)
}

variable "public_subnet_ids" {
    description = "name of web public_subnet_ids"
    default = ["aws_subnet.web1-sheila-PUB1-SUB1.id", "aws_subnet.web2-sheila-PUB2-SUB2.id"]
    type = list(string)
}