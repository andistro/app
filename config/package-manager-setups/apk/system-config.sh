#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
apt_system_icu_locale_code=$(echo "$LANG" | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')

show_progress_dialog steps-multi-label 69 \
  "${label_find_update}" 'sudo apk update' \
  "${label_upgrade}" 'sudo apk upgrade' \
  "${label_tzdata_settings}" "sudo apk add --no-cache tzdata" \
  "${label_install_script_download}\n>ca-certificates" 'sudo apk add --no-cache ca-certificates' \
  "${label_install_script_download}\n>wget" 'sudo apk add --no-cache wget' \
  "${label_install_script_download}\n>curl" 'sudo apk add --no-cache curl' \
  "${label_install_script_download}\n>gpg" 'sudo apk add --no-cache gpg' \
  "${label_install_script_download}\n>git" 'sudo apk add --no-cache git' \
  "${label_install_script_download}\n>xvfb" 'sudo apk add --no-cache xvfb' \
  "${label_install_script_download}\n>openssl" 'sudo apk add --no-cache openssl' \
  "${label_install_script_download}\n>python3" 'sudo apk add --no-cache python3' \
  "${label_install_script_download}\n>tar" 'sudo apk add --no-cache tar' \
  "${label_install_script_download}\n>unzip" 'sudo apk add --no-cache unzip' \
  "${label_install_script_download}\n>zip" 'sudo apk add --no-cache zip' \
  "${label_install_script_download}\n>tigervnc-standalone-server" 'sudo apk add --no-cache tigervnc-standalone-server' \
  "${label_install_script_download}\n>tigervnc" 'sudo apk add --no-cache tigervnc' \
  "${label_install_script_download}\n>dbus-x11" 'sudo apk add --no-cache dbus-x11' \
  "${label_install_script_download}\n>nano" 'sudo apk add --no-cache nano' \
  "${label_install_script_download}\n>nautilus" 'sudo apk add --no-cache nautilus' \
  "${label_install_script_download}\n>font-manager" 'sudo apk add --no-cache font-manager' \
  "${label_install_script_download}\n>evince" 'sudo apk add --no-cache evince' \
  "${label_install_script_download}\n>firefox" 'sudo apk add --no-cache firefox' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-icon-themes.git' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-desktop-themes.git' \
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
  "${label_system_setup}" 'sudo apt --fix-broken install'
sleep 2

{
  for i in {1..50}; do
    sleep 0.1
    echo $((i * 2))
  done
} | dialog --gauge "Iniciando as configurações do teclado, aguarde" 10 60 0
sudo dpkg-reconfigure keyboard-configuration

{
  for i in {1..50}; do
    sleep 0.1
    echo $((i * 2))
  done
} | dialog --gauge "Iniciando as configurações de fuso horário e data, aguarde" 10 60 0

#cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
#echo "America/Sao_Paulo" > /etc/timezone
