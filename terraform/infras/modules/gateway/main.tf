terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}


#
# resource "aws_apigatewayv2_domain_name" "domain" {
#   domain_name = "api.ani4h.site"
#   depends_on = [aws_acm_certificate.cert]
#   domain_name_configuration {
#     certificate_arn = aws_acm_certificate.cert.arn
#     endpoint_type   = "REGIONAL"
#     security_policy = "TLS_1_2"
#   }
# }
resource "aws_apigatewayv2_api" "rest_gateway" {
  name        = "${var.project}-gateway"
  description = "This is my API for demonstration purposes"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "v1" {
  api_id = aws_apigatewayv2_api.rest_gateway.id
  name   = "v1"
}