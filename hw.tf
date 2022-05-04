terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAEA7qiLjVSAATuwbFtahevsEFnigdkralgVB8"
  cloud_id  = "b1gvgh0p5jlr8i53p2m7"
  folder_id = "b1gra9c1ucqnfnmki3lj"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

resource "yandex_compute_instance" "vm1" {
 name = "dev"

  resources {
    cores  = 2
    memory = 2
  }

 boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
     nat       = true
   }

  metadata = {
    docker-container-declaration = file("dev.yml")
    user-data = file("user_config.yml")
  }
}
resource "yandex_compute_instance" "vm2" {
 name = "prod"

  resources {
    cores  = 2
    memory = 4
  }

 boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
     nat       = true
   }

  metadata = {
    docker-container-declaration = file("prod.yml")
    user-data = file("user_config.yml")
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
