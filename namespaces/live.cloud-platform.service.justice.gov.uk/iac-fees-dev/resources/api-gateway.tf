resource "aws_api_gateway_rest_api" "upload_files_api" {
  name        = "iac-fees-upload-files-api"
  description = "API Gateway to connect and upload files to S3"

  tags = {
    business-unit          = var.business_unit
    application            = var.application
    is-production          = var.is_production
    owner                  = var.team_name
    infrastructure-support = var.infrastructure_support
    namespace              = var.namespace
  }
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.upload_files_api.id
  parent_id   = aws_api_gateway_rest_api.upload_files_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.upload_files_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.upload_files_api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy.http_method
  type        = "AWS"

  integration_http_method = "PUT"
  uri                     = "arn:aws:apigateway:eu-west-2:s3:action/PutObject/cloud-platform-d3ad47215cc1ffea9eff85a1aa2575b6/"

  credentials = aws_iam_role.api_gateway_role.arn

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.upload_files_api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy" {
  depends_on = [
    aws_api_gateway_integration.proxy
  ]
  rest_api_id = aws_api_gateway_rest_api.upload_files_api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_iam_role" "api_gateway_role" {
  name = "api-gateway-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_put_object_policy" {
  name        = "s3-put-object-policy"
  description = "Allows API Gateway to put objects in S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPutObject",
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::cloud-platform-d3ad47215cc1ffea9eff85a1aa2575b6/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "api_gateway_s3_policy_attachment" {
  role       = aws_iam_role.api_gateway_role.name
  policy_arn = aws_iam_policy.s3_put_object_policy.arn
}

resource "aws_api_gateway_deployment" "live" {
  rest_api_id = aws_api_gateway_rest_api.upload_files_api.id
  stage_name  = "live"

  stage_description = md5(file("api-gateway.tf"))

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.proxy
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_domain_name" "apigw_fqdn" {
  domain_name              = aws_acm_certificate.apigw_custom_hostname.domain_name
  regional_certificate_arn = aws_acm_certificate_validation.apigw_custom_hostname.certificate_arn
  security_policy          = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  depends_on = [aws_acm_certificate_validation.apigw_custom_hostname]
}
