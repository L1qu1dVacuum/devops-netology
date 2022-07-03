resource "yandex_vpc_network" "network_terraform" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}