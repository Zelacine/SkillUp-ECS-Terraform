resource "aws_lb" "app" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = var.name
  }
}

resource "aws_lb_target_group" "app" {
  for_each    = var.target_groups
  name        = "${var.name}-${each.key}-tg"
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = each.value.path
    interval            = each.value.interval
    timeout             = each.value.timeout
    healthy_threshold   = each.value.healthy
    unhealthy_threshold = each.value.unhealthy
    matcher             = each.value.matcher
  }
 
  tags = {
    Name = "my-sckillup-${var.name}-${each.key}-tg"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS" 
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn
  depends_on = [var.certificate_arn]

  default_action { 
    type             = "forward"
    #target_group_arn = aws_lb_target_group.app.arn
    target_group_arn = aws_lb_target_group.app["default"].arn

  }
}

resource "aws_route53_record" "subdomain" {
  zone_id = var.route53_zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}

# Add this for the root (apex) domain
resource "aws_route53_record" "root_domain" {
  zone_id = var.route53_zone_id
  name    = var.domain_name   # e.g. world.xyz
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}