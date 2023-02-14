source "proxmox" "image-build" {
  proxmox_url              = "${var.proxmox_api_url}"
  username                 = "${var.proxmox_api_token_id}"
  token                    = "${var.proxmox_api_token_secret}"
  insecure_skip_tls_verify = "${var.insecure_skip_tls_verify}"
  node                     = "${var.pve_nodename}"
  vm_id                    = "${var.build_args[index(var.build_args.*.name, "${var.distro}-${var.distro_version}")].vm_id}"
  vm_name                  = "${var.storage_args.vm_name}"
  template_name            = "${var.storage_args.template_name}"
  template_description     = "${var.storage_args.description}"
  iso_file                 = "${var.storage_args.iso_file}"
  cores                    = "1"
  memory                   = "1024"
  scsi_controller          = "virtio-scsi-pci"
  disks {
    disk_size         = "40G"
    format            = "qcow2"
    storage_pool      = "${var.storage_args.storage_pool}"
    storage_pool_type = "${var.storage_args.storage_pool_type}"
    type              = "virtio"
  }
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    vlan_tag = "381"
    firewall = "false"
  }
  unmount_iso               = true
  qemu_agent                = true
  cloud_init                = true
  cloud_init_storage_pool   = "${var.storage_args.cloud_init_storage_pool}"
  ssh_username              = "${var.ssh_args.ssh_username}"
  ssh_timeout               = "${var.ssh_args.ssh_timeout}"
  ssh_password              = "${var.ssh_args.ssh_password}"
  ssh_clear_authorized_keys = true
  # ssh_private_key_file      = data.sshkey.install.private_key_path
  http_directory = "http"
  boot_wait      = "${var.build_args[index(var.build_args.*.name, "${var.distro}-${var.distro_version}")].boot_wait}"
  boot_command   = "${var.build_args[index(var.build_args.*.name, "${var.distro}-${var.distro_version}")].boot_command}"
}
# build instructions
build {
  name    = "image-build"
  sources = ["source.proxmox.image-build"]

  provisioner "shell" {
    script            = "exec/sysprep-${var.distro}-${var.distro_version}.sh"
    execute_command   = "sudo bash {{ .Path }}"
    pause_before      = "5s"
    expect_disconnect = true
  }
}