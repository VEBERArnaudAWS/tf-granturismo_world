resource "aws_api_gateway_rest_api" "main" {
  name        = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
  description = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
}

resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    "aws_api_gateway_integration.index-get",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${lookup(var.env_names, terraform.workspace)}"
}
