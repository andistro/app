#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
apt_system_icu_locale_code=$(echo "$LANG" | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')

show_progress_dialog steps-multi-label 72 \
  "${label_progress}" 'sudo apt autoremove --purge snapd -y' \
  "${label_progress}" 'sudo apt purge snapd -y' \
  "${label_progress}" 'sudo rm -rf /var/cache/snapd' \
  "${label_progress}" 'sudo rm -rf ~/snap' \
  "${label_progress}" 'sudo apt purge flatpak -y' \
  "${label_progress}" 'sudo apt autoremove --purge flatpak -y' \
  "${label_progress}" 'sudo rm -rf /var/cache/flatpak' \
  "${label_progress}" 'sudo apt-get clean' \
  "${label_progress}" 'sudo apt autoremove --purge whiptail -y' \
  "${label_find_update}" 'sudo apt-get update' \
  "${label_upgrade}" 'sudo apt-get full-upgrade -y' \
  "${label_keyboard_settings}" "sudo DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration -y" \
  "${label_tzdata_settings}" "sudo DEBIAN_FRONTEND=noninteractive apt install tzdata -y" \
  "${label_install_script_download}" 'sudo apt-get install xz-utils -y' \
  "${label_install_script_download}" 'sudo apt-get install wget -y' \
  "${label_install_script_download}" 'sudo apt-get install curl -y' \
  "${label_install_script_download}" 'sudo apt-get install gpg -y' \
  "${label_install_script_download}" 'sudo apt-get install git -y' \
  "${label_install_script_download}" 'sudo apt-get install python3-gi -y' \
  "${label_install_script_download}" 'sudo apt-get install python3 -y' \
  "${label_install_script_download}" 'sudo apt-get install python3-psutil -y' \
  "${label_install_script_download}" 'sudo apt-get install tar -y' \
  "${label_install_script_download}" 'sudo apt-get install unzip -y' \
  "${label_install_script_download}" 'sudo apt-get install zip -y' \
  "${label_install_script_download}" 'sudo apt-get install apt-utils -y' \
  "${label_install_script_download}" 'sudo apt-get install dconf-cli --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install lsb-release --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install exo-utils --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install tigervnc-standalone-server --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install tigervnc-common --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install tigervnc-tools --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install dbus-x11 --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install nano -y' \
  "${label_install_script_download}" 'sudo apt-get install inetutils-tools -y' \
  "${label_install_script_download}" 'sudo apt-get install nautilus --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install font-manager --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install evince -y' \
  "${label_install_script_download}" 'sudo apt-get install synaptic --no-install-recommends -y' \
  "${label_install_script_download}" "sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop" \
  "${label_install_script_download}" 'sudo apt-get install gvfs-backends --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt-get install at-spi2-core -y' \
  "${label_install_script_download}" 'sudo apt-get install bleachbit -y' \
  "${label_install_script_download}" 'sudo install -d -m 0755 /etc/apt/keyrings' \
  "${label_install_script_download}" 'wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null' \
  "${label_install_script_download}" 'echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list' \
  "${label_install_script_download}" 'echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla' \
  "${label_install_script_download}" 'sudo apt-get update && sleep 2' \
  "${label_install_script_download}" 'sudo apt-get install firefox -y' \
  "${label_install_script_download}" "sudo apt-get install firefox-l10n-$apt_system_icu_locale_code -y" \
  "${label_install_script_download}" 'wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg' \
  "${label_install_script_download}" 'sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg' \
  "${label_install_script_download}" "echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list" \
  "${label_install_script_download}" 'rm -f packages.microsoft.gpg' \
  "${label_install_script_download}" 'sudo apt-get update && sleep 2' \
  "${label_install_script_download}" 'sudo apt-get install code -y' \
  "${label_install_script_download}" "sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|' /usr/share/applications/code*.desktop" \
  "${label_install_script_download}" 'sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg' \
  "${label_install_script_download}" 'echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-icon-themes.git' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-desktop-themes.git' \
  "${label_install_script_download}" 'sudo apt-get update' \
  "${label_system_setup}" 'if [ ! -d "/root/Desktop" ]; then mkdir -p "/root/Desktop"; echo "pasta criada"; fi' \
  "${label_system_setup}" 'if [ ! -d "/usr/share/backgrounds/" ]; then mkdir -p "/usr/share/backgrounds/"; echo "pasta criada"; fi' \
  "${label_system_setup}" 'if [ ! -d "/usr/share/icons/" ]; then mkdir -p "/usr/share/icons/"; echo "pasta criada"; fi' \
  "${label_system_setup}" 'if [ ! -d "$HOME/.config/gtk-3.0" ]; then mkdir -p "$HOME/.config/gtk-3.0"; echo "pasta criada"; fi' \
  "${label_system_setup}" 'echo -e "file:/// raiz\nfile:///sdcard sdcard" | sudo tee $HOME/.config/gtk-3.0/bookmarks' \
  "${label_system_setup}" '(cd zorin-icon-themes && sudo mv Zorin*/ /usr/share/icons/)' \
  "${label_system_setup}" "cd \$HOME" \
  "${label_system_setup}" '(cd zorin-desktop-themes && sudo mv Zorin*/ /usr/share/themes/)' \
  "${label_system_setup}" "cd \$HOME" \
  "${label_system_setup}" 'rm -rf zorin-*-themes/' \
  "${label_system_setup}" "echo -e '[Settings]\\ngtk-theme-name=ZorinBlue-Dark' | sudo tee $HOME/.config/gtk-3.0/settings.ini" \
  "${label_system_setup}" "echo 'gtk-theme-name=\"ZorinBlue-Dark\"' | sudo tee $HOME/.gtkrc-2.0" \
  "${label_system_setup}" 'sudo apt-get clean' \
  "${label_system_setup}" 'sudo dpkg --configure -a ' \
  "${label_system_setup}" 'sudo apt --fix-broken install -y'
sleep 2

{
  for i in {1..50}; do
    sleep 0.1
    echo $((i * 2))
  done
} | dialog --gauge "$label_keyboard_setup" 10 60 0
sudo dpkg-reconfigure keyboard-configuration

{
  for i in {1..50}; do
    sleep 0.1
    echo $((i * 2))
  done
} | dialog --gauge "$label_tzdata_setup" 10 60 0
sudo dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

rm -rf system-config.sh