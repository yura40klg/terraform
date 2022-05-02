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
resource "yandex_compute_instance" "vm-1" {
  name = "dev"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8sc0f4358r8pt128gg"
    }
  }


  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}