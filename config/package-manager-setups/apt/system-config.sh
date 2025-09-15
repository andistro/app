#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-multi-label 66 \
  "${label_progress}" 'sudo apt clean' \
  "${label_find_update}" 'sudo apt update' \
  "${label_upgrade}" 'sudo apt full-upgrade -y' \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install tzdata --no-install-recommends -y" \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration --no-install-recommends -y" \
  "${label_install_script_download}" 'sudo apt install xz-utils --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install wget --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install curl --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install gpg --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install git --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install python3-gi --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install python3 --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install python3-psutil --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install tar --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install unzip --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install zip --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install apt-utils --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install dconf-cli --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install lsb-release --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install exo-utils --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install tigervnc-standalone-server --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install tigervnc-common --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install tigervnc-tools --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install dbus-x11 --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install nano --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install inetutils-tools --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install nautilus --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install font-manager --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install evince --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install synaptic --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install gvfs-backends --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install at-spi2-core --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install bleachbit --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo install -d -m 0755 /etc/apt/keyrings' \
  "${label_install_script_download}" 'wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null' \
  "${label_install_script_download}" 'echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list' \
  "${label_install_script_download}" 'echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla' \
  "${label_install_script_download}" 'wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg' \
  "${label_install_script_download}" 'sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg' \
  "${label_install_script_download}" "echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list" \
  "${label_install_script_download}" 'rm -f packages.microsoft.gpg' \
  "${label_install_script_download}" 'sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg' \
  "${label_install_script_download}" 'echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list' \
  "${label_install_script_download}" 'sudo apt update && sleep 2' \
  "${label_install_script_download}" 'sudo apt install firefox --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo apt install code --no-install-recommends -y' \
  "${label_install_script_download}" "sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|' /usr/share/applications/code*.desktop" \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-icon-themes.git' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-desktop-themes.git' \
  "${label_system_setup}" "sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop" \
  "${label_system_setup}" 'mkdir -p "/root/Desktop"' \
  "${label_system_setup}" 'mkdir -p "/usr/share/backgrounds/"' \
  "${label_system_setup}" 'mkdir -p "/usr/share/icons/"' \
  "${label_system_setup}" 'mkdir -p "$HOME/.config/gtk-3.0"' \
  "${label_system_setup}" 'echo -e "file:/// raiz\nfile:///sdcard sdcard" | sudo tee $HOME/.config/gtk-3.0/bookmarks' \
  "${label_system_setup}" 'cd zorin-icon-themes' \
  "${label_system_setup}" 'mv Zorin*/ /usr/share/icons/' \
  "${label_system_setup}" "cd \$HOME" \
  "${label_system_setup}" 'cd zorin-desktop-themes' \
  "${label_system_setup}" 'mv Zorin*/ /usr/share/themes/' \
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
} | dialog --no-shadow --gauge "$label_keyboard_setup" 10 60 0
sudo dpkg-reconfigure keyboard-configuration

rm -rf system-config.sh

# sudo apt install brave-browser --no-install-recommends -y
# sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/brave-browser.desktop
# sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/com.brave.Browser.desktop