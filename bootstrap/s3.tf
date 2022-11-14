
module "s3-bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.4.0"
  bucket_prefix = "state"
  force_destroy = true

  acl = "private"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }


  block_public_acls   = true
  block_public_policy = true

}

resource "aws_dynamodb_table" "terraform-state-lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "state_bucket_name" {
  value = module.s3-bucket.s3_bucket_id
}
