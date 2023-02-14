variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "distro" {
  type = string
}

variable "distro_version" {
  type = string
}

variable "insecure_skip_tls_verify" {
  type    = bool
  default = false
}

variable "ssh_args" {
  type = object({
    ssh_username = string
    ssh_timeout  = string
    ssh_password = string
  })

  default = {
    ssh_username = "ubuntu",
    ssh_timeout  = "20m"
    ssh_password = "Welcome123"
  }
}

variable "pve_nodename" {
  type    = string
  default = "pve"
}

variable "storage_args" {
  type = object({
    storage_pool            = string
    storage_pool_type       = string
    cloud_init_storage_pool = string
    iso_file                = string
    vm_name                 = string
    template_name           = string
    description             = string
  })
  default = {
    storage_pool            = "dir-sabrent-nvme-1tb"
    storage_pool_type       = "directory"
    cloud_init_storage_pool = "dir-sabrent-nvme-1tb"
    iso_file                = "HDD500:iso/ubuntu-22.04.1-live-server-amd64.iso"
    template_name           = "no-name"
    vm_name                 = "no-name"
    description             = "no-desc"
  }
}

variable "build_args" {
  type = list(object({
    name         = string
    vm_id        = number
    boot_command = list(string)
    boot_wait    = string
  }))
  default = [
    {
      name  = "ubuntu-2004"
      vm_id = 9000
      boot_command = [
        "<esc><wait><esc><wait>",
        "<f6><wait><esc><wait>",
        "<bs><bs><bs><bs><bs>",
        "ip=10.139.81.10::10.139.81.254:255.255.255.0::::10.139.81.252 autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
        "--- <enter>"
      ]
      boot_wait = "6s"
    },
    {
      name  = "ubuntu-2204"
      vm_id = 9001
      boot_command = [
        "<spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait>",
        "e<wait>",
        "<down><down><down><end>",
        " ip=10.139.81.10::11.139.81.254:255.255.255.0::::10.139.81.252 autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ",
        "<wait><f10>"
      ]
      boot_wait = "8s"
    }
  ]
}
