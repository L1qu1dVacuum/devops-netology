terraform {
  required_version = ">= 1.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.7"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "kotov-tf-state-bucket"
    region     = "ru-central1-a"
    key        = "terraform/states/terraform.tfstate"
    access_key = "AAAAAAAAAAAAAAAAAAAAAAA"
    secret_key = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}