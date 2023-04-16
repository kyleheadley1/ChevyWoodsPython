terraform {
      required_providers {
         aws = {
         source = "hashicorp/aws"
         version = "= 3.74.2"
        }
     }
  }

provider "aws" {
  region = "us-east-1"
  access_key = "AKIAS6FLDRQ55OTZLAN3"
  secret_key = "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"
}