#! /bin/bash

install_packages() {
  packages=("zip" "hyprland" "hyprpaper" "hyprlock" "wofi" "waybar" "ntfs-3g" "tree" "discord" "lazygit" "ufw" "zsh" "unzip" "wget" "stow" "curl" "yazi" "neovim" "eza" "btop" "gamemode" "steam" "mangohud" "zoxide" "fzf" "bat" "kitty" "geany" "geany-plugins" "tmux" "jdk23-openjdk" "docker" "ripgrep" "cargo" "fd" "sddm" "starship" "okular" "vlc" "xclip" "isoimagewriter" "hypridle" "pinta" "bluez" "bluez-utils" "networkmanager" "lutris")

  for package in "${packages[@]}"; do
	sudo pacman -S "$package" --noconfirm || { echo "Failed to install $package"; }
  done
}

copy_config() {
  cp "$HOME/hyprland/.zshrc" "$HOME/"
  cp -r "$HOME/hyprland/.config" "$HOME/"
  cp -r "$HOME/hyprland/Pictures/Wallpaper/" "$HOME/Pictures/"
  sudo cp -r "$HOME/hyprland/sddm/catppuccin-mocha/" "/usr/share/sddm/themes/"
  sudo cp "$HOME/hyprland/sddm/sddm.conf" "/etc/"
}

install_packages
copy_config

echo "Installing packages from yay"
yay -S --noconfirm $(cat "$HOME/hyprland/yay-packages.txt")
echo "Finished!"

