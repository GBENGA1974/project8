# PROJECT6 RDS 

# db_subnet group

resource "aws_db_subnet_group" "sheila-db-group" {
  name       = "sheila-db1"
  subnet_ids = [aws_subnet.database1-sheila-Priv3-SUB5.id, aws_subnet.database2-sheila-Priv4-SUB6.id]

  tags = {
    Name = "My RDB PRIV-subnet group"
  }
}

# aws_db_instance

resource "aws_db_instance" "RDS-sheila" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  multi_az             = true
  instance_class       = "db.t2.micro"
  name                 = "sheiladb"
  username             = "project8"
  password             = "Emmanuel1986"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.sheila-db-group.name
}



# SECURITY GROUP FOR DATABASE instance

resource "aws_security_group" "sheila-db-secgrp" {
  name              = "sheila-db_sec-group"
  description       = "Allow mysql inbound traffic"
  vpc_id            = aws_vpc.web-sheila-VPC.id

}

resource "aws_security_group_rule" "sheila-inbound" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sheila-db-secgrp.id
}

resource "aws_security_group_rule" "sheila-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sheila-db-secgrp.id
}