# Create ALB

resource "aws_lb" "dsia_alb" {
  name               = "dsia-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dsia_sg.id]
  subnets            = [aws_subnet.public_subnet_1a.id,aws_subnet.public_subnet_1c.id]

}

# create taget group

resource "aws_lb_target_group" "dsia_taget_group" {
  name     = "dsia-taget-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.dsia_vpc.id

health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    matcher             = "200"
  }

}

# Create listener

resource "aws_lb_listener" "dsia_listener" {
  load_balancer_arn = aws_lb.dsia_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dsia_taget_group.arn
  }
}

# Register an instance with a target group

resource "aws_lb_target_group_attachment" "dsia_ec2_attach" {
  target_group_arn  = aws_lb_target_group.dsia_taget_group.arn
  target_id         = aws_instance.ec2_instance_private_1a.id
}


