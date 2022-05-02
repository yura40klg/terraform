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
resource "yandex_compute_instance" "vm1" {
  name        = "dev"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
resources {
    cores  = 2
    memory = 4
  }
 boot_disk {
    initialize_params {
      image_id = "fd8sc0f4358r8pt128gg"
    }
}
network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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
      image_id = "fd8sc0f4358r8pt128gg"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

}