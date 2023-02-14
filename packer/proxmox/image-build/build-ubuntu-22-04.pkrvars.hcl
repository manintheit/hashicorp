proxmox_api_url          = "https://pve.otuken.io:8006/api2/json"
proxmox_api_token_id     = "xxxx"
proxmox_api_token_secret = "yyyy"
distro                   = "ubuntu"
distro_version           = "2204"
insecure_skip_tls_verify = true
pve_nodename             = "pve"

ssh_args = {
  ssh_username = "ubuntu"
  ssh_timeout  = "20m"
  ssh_password = "Welcome123"
}

storage_args = {
  storage_pool            = "dir-sabrent-nvme-1tb"
  storage_pool_type       = "directory"
  cloud_init_storage_pool = "dir-sabrent-nvme-1tb"
  iso_file                = "HDD500:iso/ubuntu-22.04.1-live-server-amd64.iso"
  vm_name                 = "template-ubuntu-2204"
  template_name           = "template-ubuntu-2204"
  description             = "ubuntu-2204 template"
}

// adding build_args as an array did not work

// build_args = [
//   {
//     name  = "ubuntu-2004"
//     vm_id = 9000
//     boot_command = [
//       "<esc><wait><esc><wait>",
//       "<f6><wait><esc><wait>",
//       "<bs><bs><bs><bs><bs>",
//       "ip=10.139.81.11::10.139.81.254:255.255.255.0::::10.139.81.252 autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
//       "--- <enter>"
//     ]
//     boot_wait = "7s"
//   }
// ]

