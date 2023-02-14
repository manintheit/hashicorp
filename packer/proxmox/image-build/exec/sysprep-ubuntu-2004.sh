#!/bin/bash -e

if ! cloud-init status --wait;
then
  echo "cloud-init failed" && exit 1
else
  echo "cloud-init succeeded at $(date)"
fi

apt-get update
apt-get -y upgrade
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo "cleaning logs"
if [ -f /var/log/audit/audit.log ]; then
    cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
    cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    cat /dev/null > /var/log/lastlog
fi
if [ -f /var/log/syslog ]; then
    cat /dev/null > /var/log/syslog
fi

cat /dev/null > /etc/hostname

hostnamectl set-hostname localhost

truncate -s 0 /etc/machine-id

rm -f /var/lib/dbus/machine-id

rm -f /etc/ssh/ssh_host_*

ln -s /etc/machine-id /var/lib/dbus/machine-id

rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg

echo "datasource_list: [ConfigDrive, NoCloud]" > /etc/cloud/cloud.cfg.d/99_pve.cfg

echo "removing netplan yaml files"
rm -f /etc/netplan/00-installer-config.yaml
rm -f /etc/netplan/50-cloud-init.yaml
cloud-init clean
sync
echo "done..."








