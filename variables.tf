variable "cloud_id" {
  type    = string
  default = "b1gj3qbamvs4h8r8keio"
}

variable "folder_id" {
  type    = string
  default = "b1g9af9fe1gsnt7r0n36"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "ubuntu_image_id" {
  type        = string
  default     = "fd8bu5qanc4labigou11"
}

# Общие параметры производительности для создаваемых ВМ
variable "vm_resources" {
  type = map(any)
  default = {
    platform_id   = "standard-v2"
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_size     = 10
  }
}
