resource "aws_api_gateway_method" "index-get" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "index-get" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_method.index-get.resource_id}"
  http_method = "${aws_api_gateway_method.index-get.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.index.invoke_arn}"
}

resource "aws_api_gateway_method_settings" "index-get" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  method_path = "*/${aws_api_gateway_method.index-get.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "ERROR"
  }
}
