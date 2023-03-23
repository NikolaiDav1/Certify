terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "vm-1" {
  name = "buildvm"
  hostname = "buildvm"
  platform_id = "standard-v3"
  zone = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8snjpoq85qqv0mk9gi"
      type = "network-ssd"
      size = 20
    }
  }

  network_interface {
    subnet_id = "e2li090i1k034aacdm99"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  provisioner "remote-exec" {
    inline = ["sudo apt -y install python3"]

    connection {
      host        = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }
}

output "ipaddress" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

