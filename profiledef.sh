#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="jker-os"
iso_label="jker-os"
iso_publisher="Jker OS Team <jker@localhost>"
iso_application="Jker OS Live/Rescue ISO"
iso_version="2026.07"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86')
bootstrap_tarball_compression=('zstd' '-c' '19' '-T0' '--long')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/live-wallpaper.sh"]="0:0:755"
  ["/usr/local/bin/live-wallpaper-stop.sh"]="0:0:755"
)
