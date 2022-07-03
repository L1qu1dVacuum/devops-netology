locals {
  web_instance_type_map = {
    stage = "ubuntu-2004-lts"
    prod  = "debian-11"
  }
}

locals {
  web_instance_count_map = {
    stage = 1
    prod  = 2
  }
}

locals {
  web_instance_each_map = toset([
    "each_01",
    "each_02",
  ])
}