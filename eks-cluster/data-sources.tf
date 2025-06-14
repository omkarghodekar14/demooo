data "aws_ssm_parameter" "vpc_id" {
  name = "/vpc/id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "/vpc/private_subnet_ids"
}

data "aws_ssm_parameter" "public_subnets" {
  name = "/vpc/public_subnet_ids"
}
