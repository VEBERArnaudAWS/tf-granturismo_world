resource "aws_api_gateway_resource" "about" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "about"
}

resource "aws_api_gateway_method" "about-get" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_resource.about.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "about-get" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_method.about-get.resource_id}"
  http_method = "${aws_api_gateway_method.about-get.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.about.invoke_arn}"
}

resource "aws_api_gateway_method_settings" "about-get" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  method_path = "${aws_api_gateway_resource.about.path_part}/${aws_api_gateway_method.about-get.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "ERROR"
  }
}
