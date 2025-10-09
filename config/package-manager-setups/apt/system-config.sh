#!/bin/bash
distro_theme="$1"
# Fonte modular configuração global
source "/usr/local/bin/andistro/global"

# Baixa os pacotes base, um por um
show_progress_dialog steps-multi-label 65 \
  "${label_progress}" 'echo "system-config"' \
  "${label_progress}" 'sudo apt clean' \
  "${label_find_update}" 'sudo apt update' \
  "${label_upgrade}" 'sudo apt full-upgrade -y' \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install tzdata --no-install-recommends -y" \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration --no-install-recommends -y" \
  "${label_install_script_download}\n\n → xz-utils" 'sudo apt install xz-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → wget" 'sudo apt install wget --no-install-recommends -y' \
  "${label_install_script_download}\n\n → curl" 'sudo apt install curl --no-install-recommends -y' \
  "${label_install_script_download}\n\n → gpg" 'sudo apt install gpg --no-install-recommends -y' \
  "${label_install_script_download}\n\n → git" 'sudo apt install git --no-install-recommends -y' \
  "${label_install_script_download}\n\n → python3" 'sudo apt install python3 --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tar" 'sudo apt install tar --no-install-recommends -y' \
  "${label_install_script_download}\n\n → unzip" 'sudo apt install unzip --no-install-recommends -y' \
  "${label_install_script_download}\n\n → zip" 'sudo apt install zip --no-install-recommends -y' \
  "${label_install_script_download}\n\n → apt-utils" 'sudo apt install apt-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → lsb-release" 'sudo apt install lsb-release --no-install-recommends -y' \
  "${label_install_script_download}\n\n → exo-utils" 'sudo apt install exo-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-standalone-server" 'sudo apt install tigervnc-standalone-server --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-common" 'sudo apt install tigervnc-common --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-tools" 'sudo apt install tigervnc-tools --no-install-recommends -y' \
  "${label_install_script_download}\n\n → dbus-x11" 'sudo apt install dbus-x11 --no-install-recommends -y' \
  "${label_install_script_download}\n\n → nano" 'sudo apt install nano --no-install-recommends -y' \
  "${label_install_script_download}\n\n → inetutils-tools" 'sudo apt install inetutils-tools --no-install-recommends -y' \
  "${label_install_script_download}\n\n → net-tools" 'sudo apt install net-tools --no-install-recommends -y' \
  "${label_install_script_download}\n\n → font-manager" 'sudo apt install font-manager --no-install-recommends -y' \
  "${label_install_script_download}\n\n → synaptic" 'sudo apt install synaptic --no-install-recommends -y' \
  "${label_install_script_download}\n\n → gvfs-backends" 'sudo apt install gvfs-backends --no-install-recommends -y' \
  "${label_install_script_download}\n\n → bleachbit" 'sudo apt install bleachbit --no-install-recommends -y' \
  "${label_install_script_download}\n\n → pulseaudio" 'sudo apt install pulseaudio --no-install-recommends -y' \
  "${label_install_script_download}\n\n → pavucontrol" 'sudo apt install pavucontrol --no-install-recommends -y' \
  "${label_install_script_download}\n\n → make" 'sudo apt install make --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tumbler" 'sudo apt install tumbler --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo dpkg --configure -a' \
  "${label_install_script_download}" 'sudo apt --fix-broken install -y' \
  "${label_install_script_download}\n\n → firefox" 'sudo install -d -m 0755 /etc/apt/keyrings' \
  "${label_install_script_download}\n\n → firefox" 'wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null' \
  "${label_install_script_download}\n\n → firefox" 'echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list' \
  "${label_install_script_download}\n\n → firefox" 'echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla' \
  "${label_install_script_download}\n\n → firefox" 'sudo apt update && sleep 2' \
  "${label_install_script_download}\n\n → firefox" 'sudo apt install firefox --no-install-recommends -y' \
  "${label_install_script_download}" 'wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg' \
  "${label_install_script_download}" 'sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg' \
  "${label_install_script_download}" "echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list" \
  "${label_install_script_download}" 'rm -f packages.microsoft.gpg' \
  "${label_install_script_download}" "sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|' /usr/share/applications/code*.desktop" \
  "${label_install_script_download}" 'sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg' \
  "${label_install_script_download}" 'echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list' \
  "${label_install_script_download}" 'sudo apt update && sleep 2' \
  "${label_install_script_download}" 'sleep 5' \
  "${label_system_setup}" 'mkdir -p "/usr/share/backgrounds/"' \
  "${label_system_setup}" 'mkdir -p "/usr/share/icons/"' \
  "${label_system_setup}" 'mkdir -p "$HOME/.config/gtk-3.0"' \
  "${label_system_setup}" 'echo -e "file:///sdcard sdcard" | sudo tee $HOME/.config/gtk-3.0/bookmarks' \
  "${label_system_setup}\n\n → ${label_themes}: andistro-themes" 'git clone https://github.com/andistro/themes.git' \
  "${label_system_setup}\n\n → ${label_themes}: andistro-themes" 'mv themes/AnDistro*/ /usr/share/themes/' \
  "${label_system_setup}\n\n → ${label_icons}: zorin-icon-themes" 'git clone https://github.com/ZorinOS/zorin-icon-themes.git' \
  "${label_system_setup}\n\n → ${label_icons}: zorin-icon-themes" 'mv zorin-icon-themes/Zorin*/ /usr/share/icons/' \
  "${label_system_setup}\n\n → synaptic" "sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop" \
  "${label_system_setup}" 'rm -rf zorin-*-themes/' \
  "${label_system_setup}" "echo -e '[Settings]\ngtk-theme-name=AnDistro-Majorelle-Blue-${distro_theme}' | sudo tee $HOME/.config/gtk-3.0/settings.ini" \
  "${label_system_setup}" "echo 'gtk-theme-name=\"AnDistro-Majorelle-Blue-${distro_theme}\"' | sudo tee $HOME/.gtkrc-2.0" \
  "${label_system_setup}" 'sudo apt-get clean' \
  "${label_system_setup}" 'sudo dpkg --configure -a' \
  "${label_system_setup}" 'sudo apt --fix-broken install -y'
sleep 2

#show_progress_dialog check-packages "Verificando" tzdata xz-utils keyboard-configuration wget curl gpg git python3 tar unzip zip apt-utils lsb-release exo-utils tigervnc-standalone-server tigervnc-common tigervnc-tools dbus-x11 nano inetutils-tools net-tools font-manager synaptic gvfs-backends bleachbit pulseaudio pavucontrol make tumbler firefox code

# Tempo de 10s antes de inicializar as configurações do teclado
{
 for i in {1..50}; do
   sleep 0.1
   echo $((i * 2))
 done
} | dialog --no-shadow --gauge "$label_keyboard_setup" 10 60 0
sudo dpkg-reconfigure keyboard-configuration

# Remove o arquivo do sistema
rm -rf system-config.sh

#"${label_install_script_download}\n\n → ffmpegthumbnailer" 'sudo apt install ffmpegthumbnailer --no-install-recommends -y' \