resource "aws_iam_role" "apigateway" {
  name = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}-apigateway"

  assume_role_policy = "${data.aws_iam_policy_document.apigateway_assume_role.json}"

  tags = {
    Application = "${var.application}"
    Environment = "${lookup(var.env_names, terraform.workspace)}"
    Workspace   = "${terraform.workspace}"
    terraformed = "true"
  }
}

resource "aws_iam_role_policy_attachment" "apigateway" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = "${aws_iam_role.apigateway.name}"
}
