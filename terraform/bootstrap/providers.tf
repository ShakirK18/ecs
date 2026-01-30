provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = ">=1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.28"
    }
  }
}

terraform {
  backend "s3" {
    bucket       = "tfstate-shakir"
    key          = "bootstrap.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}