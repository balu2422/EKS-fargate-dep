terraform {
  required_version = ">= 1.1.0"
  backend "s3" {
    bucket         = "2-tier-architecture-modules"
    key            = "tf/state6"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "2-tier-architecture-modules-table"
  }
}
