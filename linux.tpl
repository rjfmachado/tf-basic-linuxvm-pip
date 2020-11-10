#cloud-config
runcmd:
  - curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
  - echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" | tee /etc/apt/sources.list.d/azure-cli.list
  - apt update
  - apt install --yes --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" azure-cli dnsutils ca-certificates curl apt-transport-https lsb-release gnupg
  - sed -i "s/127.0.0.1\ localhost/127.0.0.1\ localhost\ $(hostname)/g" /etc/hosts
  - sed '15 s/\///g' -i /etc/apt/apt.conf.d/50unattended-upgrades
  - sed '20 a Unattended-Upgrade::Automatic-Reboot "true";' -i /etc/apt/apt.conf.d/50unattended-upgrades
  - sed '20 a Unattended-Upgrade::Automatic-Reboot-Time "02:00";' -i /etc/apt/apt.conf.d/50unattended-upgrades
  - sed '20 a Unattended-Upgrade::Remove-Unused-Dependencies "true";' -i /etc/apt/apt.conf.d/50unattended-upgrades
