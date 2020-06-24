#!/run/current-system/sw/bin/bash

echo "[MBR] Formating..."

parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB -40GiB
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

mkfs.ext4 -L NixOS /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mount /dev/sda1 /mnt

echo "[MBR] Formating Done!"

echo "[NIXOS] Generating config"
nixos-generate-config --root /mnt
echo "[NIXOS] Generated!"

echo "[INFO] To edit the config, run: nano /mnt/etc/nixos/configuration.nix"
echo "[INFO] After editing, run: nixos-install"
echo "[INFO] At the end, run: reboot"
