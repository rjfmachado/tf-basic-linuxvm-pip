variable "rg" {
  type = string
}

variable "name" {
  type = string
}

variable "adminuser" {
  type    = string
  default = "ricardma"
}

variable "sshkey" {
  type = string
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "size" {
  type    = string
  default = "Standard_B1s"
}

variable "storage_type" {
  type    = string
  default = "Premium_LRS"
}

variable "subnetid" {
}

variable "cloud-config" {
  type    = string
  default = "linux.tpl"
}

variable "zone" {
  type    = string
  default = "1"
}
