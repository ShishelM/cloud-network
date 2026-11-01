# NAT-инстанс в публичной подсети
resource "yandex_compute_instance" "nat" {
  name        = "nat-instance"
  zone        = var.default_zone
  platform_id = var.vm_resources["platform_id"]

  resources {
    cores         = var.vm_resources["cores"]
    memory        = var.vm_resources["memory"]
    core_fraction = var.vm_resources["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      size     = var.vm_resources["disk_size"]
    #   type = "network-ssd"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254" # Фиксированный IP для таблицы маршрутизации
    nat        = true
    security_group_ids = [yandex_vpc_security_group.allow_ssh_icmp.id]

  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }
}

# Виртуалка в публичной подсети
resource "yandex_compute_instance" "public_vm" {
  name        = "public-vm"
  zone        = var.default_zone
  platform_id = var.vm_resources["platform_id"]

  resources {
    cores         = var.vm_resources["cores"]
    memory        = var.vm_resources["memory"]
    core_fraction = var.vm_resources["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = var.vm_resources["disk_size"]
    #   type = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.allow_ssh_icmp.id]

  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }
}

# Виртуалка в приватной подсети
resource "yandex_compute_instance" "private_vm" {
  name        = "private-vm"
  zone        = var.default_zone
  platform_id = var.vm_resources["platform_id"]

  resources {
    cores         = var.vm_resources["cores"]
    memory        = var.vm_resources["memory"]
    core_fraction = var.vm_resources["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = var.vm_resources["disk_size"]
      type = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false # Только внутренний IP
    security_group_ids = [yandex_vpc_security_group.allow_ssh_icmp.id]

  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }
}
