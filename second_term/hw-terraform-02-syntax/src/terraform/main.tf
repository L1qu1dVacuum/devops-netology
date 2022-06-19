provider "yandex" {
  token      = "${var.token}"
  cloud_id   = "b1g70kshj08c47m21dda"
  folder_id  = "b1gmjbll9tsenitvtbv4"
  zone       = "ru-central1-a"
}

resource "yandex_compute_instance" "default" {
  name = "test"

  resources {
      cores  = 1
      memory = 2
    }

    boot_disk {
      initialize_params {
        image_id    = "packer.img"
        type        = "network-nvme"
        size        = "10"
      }
    }

    network_interface {
      subnet_id = "${yandex_vpc_subnet.default.id}"
      nat       = true
    }

    metadata = {
      ssh-keys = "packer.img:${file("~/.ssh/id_rsa.pub")}"
    }
}
