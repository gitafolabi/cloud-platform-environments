module "risk_profiler_s3_bucket" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.8.2"
  team_name              = var.team_name
  acl                    = "private"
  versioning             = false
  business-unit          = var.business_unit
  application            = var.application
  is-production          = var.is_production
  environment-name       = var.environment_name
  infrastructure-support = var.infrastructure_support
  namespace              = var.namespace


  bucket_policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS":
                  [
                    "arn:aws:iam::593291632749:role/airflow_prod_sdt_viper_to_external"
                  ]
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObjectAcl",
                "s3:GetObjectVersion",
                "s3:DeleteObject",
                "s3:DeleteObjectVersion",
                "s3:RestoreObject"
            ],
            "Resource": [
                "$${bucket_arn}/viper/*"
            ]
        }
    ]
}
EOF

}

resource "kubernetes_secret" "risk_profiler_s3_bucket" {
  metadata {
    name      = "risk-profiler-s3-bucket-output"
    namespace = var.namespace
  }

  data = {
    bucket_arn        = module.risk_profiler_s3_bucket.bucket_arn
    bucket_name       = module.risk_profiler_s3_bucket.bucket_name
  }
}
