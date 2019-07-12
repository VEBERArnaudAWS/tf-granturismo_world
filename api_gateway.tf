resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = "${aws_iam_role.apigateway.arn}"

  lifecycle {
    ignore_changes = [
      cloudwatch_role_arn
    ]
  }
}

resource "aws_api_gateway_rest_api" "main" {
  name        = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
  description = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
}

resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    "aws_api_gateway_integration.index-get",
    "aws_api_gateway_integration.about-get",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${lookup(var.env_names, terraform.workspace)}"
}

resource "aws_api_gateway_domain_name" "main" {
  certificate_arn = "${aws_acm_certificate_validation.main.certificate_arn}"
  domain_name     = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
}

resource "aws_api_gateway_base_path_mapping" "main" {
  api_id      = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.main.domain_name}"
}
