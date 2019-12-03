output "account_id" {
    value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
    value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
    value = "${data.aws_caller_identity.current.user_id}"
}

output "canonical_user_id" {
    value = "${data.aws_canonical_user_id.current.id}"
}

output "region" {
    value = "${data.aws_region.current.name}"
}

output "terraform_workspace" {
    value = "${terraform.workspace}"
}

output "availability_zones" {
    value = "${data.aws_availability_zones.available.names}"
}

output "random_test" {
    value = "${random_id.id.hex}" 
}

output "my_bucket"{
    value = "${local.bucket_name}"
}

output "my_bucket_arn"{
    value = "${aws_s3_bucket.helm-repo-bucket.arn}"
}

output "account_arn"{
    value = "${local.account_arn}"
}

output "bucket_policy"{
    value = "${data.aws_iam_policy_document.helm_bucket.json}"
}

output "admin_whitelist"{
    value = "${var.admin_whitelist}"
}

output "read_whitelist"{
    value = "${var.read_whitelist}"
}

