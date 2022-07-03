# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ."


## Задача 1


## Задача 2


Вывод команды `terraform workspace list`.

```bash
> $ terraform workspace list                                                                                [±main ●●●]
  default
* prod
  stage
```

Вывод команды `terraform plan` для воркспейса `prod`.

```bash
> $ terraform plan                                                                                          [±main ●●●]
data.yandex_compute_image.linux_image: Reading...
data.yandex_compute_image.linux_image: Read complete after 0s [id=fd8688pbq9gmdal33a0d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.test_01[0] will be created
  + resource "yandex_compute_instance" "test_01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: test
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh-authorized-keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8FrQVOMTJOpzrEBBj0xLovVgJwmc7T0Ol/7LbD7dEbQBG95pK6HACkSyYXzLYp4tW7Mb5aNzrYHyezTTTLC4GVl5/Hxwv7RAOCcT5dW0uQkVNtx3hGNDm48rDuugwY8Jy9A45ZxR1UcRc7rnP361a07Vd4RxvWChMK5oUIvkIMcFH2FZeT8uHEIe3Gm+fbWXDtWdm3BQq6+GziDXN6k77CtxbEteoYPS781Gja64AOpcObzQasmQdV0J0nFVqA45yniKkNmV9s32IqLqQnTxCvxlDy1DWepkOK7Olm9aLG3NVYrLGFJxKna7uHb2AY7JGGqJjKWEH7shKbBS+YwgNoj0dYRiOcZEw0Ecpaczz29uVLlKO1l8lDhQNKzB6X3W9WPcJVqi7hJ93V2rW8nGmQN6itkjK5cUbGj4eBHNUpxMeCd6QIAbJLZDdV3fgkRDOb4aKJm+o9x9zEL9ERKLwINl95qSG30ZMu3TpFYlsaY59gNVnbqREmY03BWK7/fc=
            EOT
        }
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8688pbq9gmdal33a0d"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.test_01[1] will be created
  + resource "yandex_compute_instance" "test_01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: test
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh-authorized-keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8FrQVOMTJOpzrEBBj0xLovVgJwmc7T0Ol/7LbD7dEbQBG95pK6HACkSyYXzLYp4tW7Mb5aNzrYHyezTTTLC4GVl5/Hxwv7RAOCcT5dW0uQkVNtx3hGNDm48rDuugwY8Jy9A45ZxR1UcRc7rnP361a07Vd4RxvWChMK5oUIvkIMcFH2FZeT8uHEIe3Gm+fbWXDtWdm3BQq6+GziDXN6k77CtxbEteoYPS781Gja64AOpcObzQasmQdV0J0nFVqA45yniKkNmV9s32IqLqQnTxCvxlDy1DWepkOK7Olm9aLG3NVYrLGFJxKna7uHb2AY7JGGqJjKWEH7shKbBS+YwgNoj0dYRiOcZEw0Ecpaczz29uVLlKO1l8lDhQNKzB6X3W9WPcJVqi7hJ93V2rW8nGmQN6itkjK5cUbGj4eBHNUpxMeCd6QIAbJLZDdV3fgkRDOb4aKJm+o9x9zEL9ERKLwINl95qSG30ZMu3TpFYlsaY59gNVnbqREmY03BWK7/fc=
            EOT
        }
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8688pbq9gmdal33a0d"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.test_02["each_01"] will be created
  + resource "yandex_compute_instance" "test_02" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: test
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh-authorized-keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8FrQVOMTJOpzrEBBj0xLovVgJwmc7T0Ol/7LbD7dEbQBG95pK6HACkSyYXzLYp4tW7Mb5aNzrYHyezTTTLC4GVl5/Hxwv7RAOCcT5dW0uQkVNtx3hGNDm48rDuugwY8Jy9A45ZxR1UcRc7rnP361a07Vd4RxvWChMK5oUIvkIMcFH2FZeT8uHEIe3Gm+fbWXDtWdm3BQq6+GziDXN6k77CtxbEteoYPS781Gja64AOpcObzQasmQdV0J0nFVqA45yniKkNmV9s32IqLqQnTxCvxlDy1DWepkOK7Olm9aLG3NVYrLGFJxKna7uHb2AY7JGGqJjKWEH7shKbBS+YwgNoj0dYRiOcZEw0Ecpaczz29uVLlKO1l8lDhQNKzB6X3W9WPcJVqi7hJ93V2rW8nGmQN6itkjK5cUbGj4eBHNUpxMeCd6QIAbJLZDdV3fgkRDOb4aKJm+o9x9zEL9ERKLwINl95qSG30ZMu3TpFYlsaY59gNVnbqREmY03BWK7/fc=
            EOT
        }
      + name                      = "each_01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8688pbq9gmdal33a0d"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.test_02["each_02"] will be created
  + resource "yandex_compute_instance" "test_02" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: test
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh-authorized-keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8FrQVOMTJOpzrEBBj0xLovVgJwmc7T0Ol/7LbD7dEbQBG95pK6HACkSyYXzLYp4tW7Mb5aNzrYHyezTTTLC4GVl5/Hxwv7RAOCcT5dW0uQkVNtx3hGNDm48rDuugwY8Jy9A45ZxR1UcRc7rnP361a07Vd4RxvWChMK5oUIvkIMcFH2FZeT8uHEIe3Gm+fbWXDtWdm3BQq6+GziDXN6k77CtxbEteoYPS781Gja64AOpcObzQasmQdV0J0nFVqA45yniKkNmV9s32IqLqQnTxCvxlDy1DWepkOK7Olm9aLG3NVYrLGFJxKna7uHb2AY7JGGqJjKWEH7shKbBS+YwgNoj0dYRiOcZEw0Ecpaczz29uVLlKO1l8lDhQNKzB6X3W9WPcJVqi7hJ93V2rW8nGmQN6itkjK5cUbGj4eBHNUpxMeCd6QIAbJLZDdV3fgkRDOb4aKJm+o9x9zEL9ERKLwINl95qSG30ZMu3TpFYlsaY59gNVnbqREmY03BWK7/fc=
            EOT
        }
      + name                      = "each_02"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8688pbq9gmdal33a0d"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_iam_service_account.sa will be created
  + resource "yandex_iam_service_account" "sa" {
      + created_at = (known after apply)
      + folder_id  = "b1gmjbll9tsenitvtbv4"
      + id         = (known after apply)
      + name       = "sa-test"
    }

  # yandex_iam_service_account_static_access_key.sa-static-key will be created
  + resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
      + access_key           = (known after apply)
      + created_at           = (known after apply)
      + description          = "Static access key for object storage"
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = (known after apply)
    }

  # yandex_resourcemanager_folder_iam_member.sa-editor will be created
  + resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
      + folder_id = "b1gmjbll9tsenitvtbv4"
      + id        = (known after apply)
      + member    = (known after apply)
      + role      = "storage.editor"
    }

  # yandex_storage_bucket.state will be created
  + resource "yandex_storage_bucket" "state" {
      + access_key            = (known after apply)
      + acl                   = "private"
      + bucket                = "kotov-tf-state-bucket"
      + bucket_domain_name    = (known after apply)
      + default_storage_class = (known after apply)
      + folder_id             = (known after apply)
      + force_destroy         = false
      + id                    = (known after apply)
      + secret_key            = (sensitive value)
      + website_domain        = (known after apply)
      + website_endpoint      = (known after apply)

      + anonymous_access_flags {
          + list = (known after apply)
          + read = (known after apply)
        }

      + versioning {
          + enabled = (known after apply)
        }
    }

  # yandex_vpc_network.network_terraform will be created
  + resource "yandex_vpc_network" "network_terraform" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet_terraform will be created
  + resource "yandex_vpc_subnet" "subnet_terraform" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.10.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + access_key = (sensitive value)
  + secret_key = (sensitive value)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```
