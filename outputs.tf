output "public_vm_external_ip" {
  value       = yandex_compute_instance.public_vm.network_interface[0].nat_ip_address
  description = "Внешний IP-адрес публичной машины"
}

output "private_vm_internal_ip" {
  value       = yandex_compute_instance.private_vm.network_interface[0].ip_address
  description = "Внутренний IP-адрес приватной машины"
}

output "nat_instance_internal_ip" {
  value       = yandex_compute_instance.nat.network_interface[0].ip_address
  description = "Внутренний IP-адрес NAT-инстанса"
}

output "homework_report" {
  value = <<-EOT
Подключение к публичной машине:
     ssh pavel@${yandex_compute_instance.public_vm.network_interface[0].nat_ip_address}

Доступность интернета:
     ping -c 4 8.8.8.8

Подключение через публичную ВМ к приватной:
    ssh -J pavel@${yandex_compute_instance.public_vm.network_interface[0].nat_ip_address} pavel@${yandex_compute_instance.private_vm.network_interface[0].ip_address}

Проверка трафика из закрытого контура во внешний мир через NAT-инстанс:
    ping -c 4 yandex.ru
  EOT

  description = "Готовая фактура отчета для отправки задания"
}
