data "aws_iam_policy_document" "lambda_assume_role" {
  statement = {
    effect = "Allow"

    principals = {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "index" {
  name = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}-index"

  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role.json}"

  tags = {
    Application = "${var.application}"
    Environment = "${lookup(var.env_names, terraform.workspace)}"
    Workspace   = "${terraform.workspace}"
    terraformed = "true"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = "${aws_iam_role.index.name}"
}
