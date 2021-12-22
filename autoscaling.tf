# AUTOSCALING GROUP STEPS 
# PLACEMENT GROUP(aws_placement_group)

resource "aws_placement_group" "sheila-plg1" {
  name     = "sheila-plg"
  strategy = "partition"
}

# launch_configuration

resource "aws_launch_configuration" "sheila-ltp" {
  name_prefix   = "Launch_Template"
  image_id      = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"

 # key_name = "EC2 PRACTICE"

  lifecycle {
      create_before_destroy = true
  }
}

# aws_autoscaling_group

resource "aws_autoscaling_group" "sheila-auto" {
  name                      = "mys-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.sheila-plg1.id
  launch_configuration      = aws_launch_configuration.sheila-ltp.name
  vpc_zone_identifier       = [aws_subnet.web1-sheila-PUB1-SUB1.id, aws_subnet.web2-sheila-PUB2-SUB2.id]
  target_group_arns         = [aws_alb_target_group.sheila_alb_target_group.arn]

  lifecycle {
      create_before_destroy = true
  }

  tag {
    key                 = "name"
    value               = "mys-asg"
    propagate_at_launch = true
  }

}