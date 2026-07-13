#!/usr/bin/env bash
# Jker-OS automated live environment setup script
# Runs on first boot of the live ISO

set -euo pipefail

install -d -m 0700 /root/.gnupg

# Enable LightDM on boot
systemctl enable lightdm.service

# Enable NetworkManager
systemctl enable NetworkManager.service

# Set Jker-OS hostname
echo "jker-os" > /etc/hostname

# Generate locales
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Create live user from skel
if ! id liveuser &>/dev/null; then
    useradd -m -G wheel,liveuser -s /bin/bash liveuser
    echo "liveuser:liveuser" | chpasswd
fi

# Copy skel to liveuser home if empty
if [[ ! -f /home/liveuser/.config/kdeglobals ]]; then
    cp -a /etc/skel/. /home/liveuser/
    chown -R liveuser:liveuser /home/liveuser
fi

# Ensure live wallpaper script is executable
chmod +x /usr/local/bin/live-wallpaper.sh
chmod +x /usr/local/bin/live-wallpaper-stop.sh

# Update GRUB theme if grub is installed
if [[ -d /boot/grub ]]; then
    grub-mkconfig -o /boot/grub/grub.cfg 2>/dev/null || true
fi

echo "Jker-OS live environment configured."
