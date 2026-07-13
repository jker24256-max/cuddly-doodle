#!/usr/bin/env bash
# Jker-OS airootfs customization hook — runs during archiso build inside chroot

set -euo pipefail

echo "==> Jker-OS: customizing airootfs..."

# Enable services
systemctl enable lightdm.service
systemctl enable NetworkManager.service
systemctl enable systemd-resolved.service
systemctl enable jker-live-setup.service

# Set locale
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Ensure script permissions
chmod +x /usr/local/bin/live-wallpaper.sh
chmod +x /usr/local/bin/live-wallpaper-stop.sh
chmod +x /usr/local/bin/choose-mirror
chmod +x /usr/local/bin/Installation_guide
chmod +x /root/.automated_script.sh

# Create liveuser with themed skel
if ! getent passwd liveuser &>/dev/null; then
    useradd -m -G wheel,liveuser -s /bin/bash liveuser
    echo "liveuser:liveuser" | chpasswd
fi

# Apply skel configuration to liveuser
if [[ -d /home/liveuser ]]; then
    cp -aT /etc/skel /home/liveuser
    chown -R liveuser:liveuser /home/liveuser
fi

# Ensure asset directory exists
install -d -m 0755 /usr/share/jker-os/assets

# Pre-create runtime dir marker
install -d -m 0755 /etc/skel/.config/autostart

echo "==> Jker-OS: airootfs customization complete."
