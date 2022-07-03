provider "yandex" {
  token      = var.token
  cloud_id   = var.yandex_cloud_id
  folder_id  = var.yandex_folder_id
  zone       = "ru-central1-a"
}

data "yandex_compute_image" "linux_image" {
  family = local.web_instance_type_map[terraform.workspace]
}

resource "yandex_compute_instance" "test_01" {
  count = local.web_instance_count_map[terraform.workspace]
  allow_stopping_for_update = true

  lifecycle {
    create_before_destroy = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.linux_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "test_02" {
  for_each = local.web_instance_each_map
  name = each.key
  allow_stopping_for_update = true

  lifecycle {
    create_before_destroy = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.linux_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}