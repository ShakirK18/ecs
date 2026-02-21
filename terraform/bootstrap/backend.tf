terraform {
  backend "s3" {
    bucket       = "tfstate-shakir"
    key          = "bootstrap.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}