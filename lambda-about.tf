resource "aws_lambda_function" "about" {
  function_name = "${replace(var.application, ".", "_")}_${replace(lookup(var.env_dns_zones_prefix,
  terraform.workspace), ".", "_")}${replace(var.domain, ".", "_")}-about"

  s3_bucket = "${aws_s3_bucket.deployment.id}"
  s3_key    = "${lookup(var.s3_deployment_prefix, terraform.workspace)}/about.zip"

  runtime = "nodejs8.10"
  handler = "lambda.handler"

  role = "${aws_iam_role.about.arn}"

  environment {
    variables = {
      ASSET_PREFIX = "https://asset.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}"
    }
  }

  tags = {
    Application = "${var.application}"
    Environment = "${lookup(var.env_names, terraform.workspace)}"
    Workspace   = "${terraform.workspace}"
    terraformed = "true"
  }
}

resource "aws_lambda_permission" "about" {
  statement_id  = "apigateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.about.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.main.execution_arn}/${aws_api_gateway_method.about-get.http_method}/*"
}
