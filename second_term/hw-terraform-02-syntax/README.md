# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."


## Задача 1

```yaml
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "${var.token}"
  cloud_id  = "b1g70kshj08c47m21dda"
  folder_id = "b1gmjbll9tsenitvtbv4"
  zone      = "ru-central1-a"
}
```

```bash
Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.75.0...
- Installed yandex-cloud/yandex v0.75.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```


## Задача 2


1. Packer

2. [Ссылка на репозиторий с исходной конфигурацией терраформа](https://github.com/L1qu1dVacuum/devops-netology/tree/main/second_term/hw-terraform-02-syntax/src/terraform)
