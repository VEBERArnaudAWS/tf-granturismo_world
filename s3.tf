resource "aws_s3_bucket" "deployment" {
  bucket = "${var.application}.${lookup(var.env_dns_zones_prefix, terraform.workspace)}${var.domain}-deployment"

  tags = {
    Application = "${var.application}"
    Environment = "${lookup(var.env_names, terraform.workspace)}"
    Workspace   = "${terraform.workspace}"
    terraformed = "true"
  }
}
