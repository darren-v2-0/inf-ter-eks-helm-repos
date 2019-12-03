terraform {
  required_version = "0.11.7"
}

data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "central"
  region = "eu-central-1"
}

data "aws_iam_policy_document" "helm_bucket" {
  statement {
   principals {
     type        = "AWS"
     identifiers = ["*"],
   }   
    sid = "readaccess"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
        "${aws_s3_bucket.helm-repo-bucket.arn}/*",
        "${aws_s3_bucket.helm-repo-bucket.arn}"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = [
        "${var.read_whitelist}"
      ]
    }
  },
  statement {
   principals {
     type        = "AWS"
     identifiers = ["*"],
   }   
    sid = "adminaccess"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
        "${aws_s3_bucket.helm-repo-bucket.arn}/*",
        "${aws_s3_bucket.helm-repo-bucket.arn}"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = [
        "${var.read_whitelist}"
      ]
    }
  }
}

resource "random_id" "id" {
  byte_length = 8
}

locals{
    bucket_name = "${random_id.id.hex}-helm-repo-${terraform.workspace}"
    account_arn = "${data.aws_caller_identity.current.arn}"
    }

resource "aws_s3_bucket" "helm-repo-bucket" {
    bucket = "${local.bucket_name}"
    force_destroy = true
    acl    = "private"
    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.helm_key.arn}"
        sse_algorithm     = "aws:kms"
            }
        }
    }
    tags {
        Terraform = "true"
        Workspace = "${terraform.workspace}"
        Environment = "${var.environment}"
    }
}

resource "aws_s3_bucket_policy" "helm_policy_attach" {
    bucket = "${aws_s3_bucket.helm-repo-bucket.id}"
    policy = "${data.aws_iam_policy_document.helm_bucket.json}"
}

resource "aws_kms_key" "helm_key" {
  description             = "This key is used to encrypt the helm repo bucket objects"
  deletion_window_in_days = 10
}

