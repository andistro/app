#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
apt_system_icu_locale_code=$(echo "$LANG" | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')

show_progress_dialog steps-multi-label 22 \
  "${label_find_update}" 'sudo apk update' \
  "${label_upgrade}" 'sudo apk upgrade' \
  "${label_tzdata_settings}" "sudo apk add --no-cache tzdata" \
  "${label_install_script_download}" 'sudo apk add --no-cache ca-certificates' \
  "${label_install_script_download}" 'sudo apk add --no-cache wget' \
  "${label_install_script_download}" 'sudo apk add --no-cache curl' \
  "${label_install_script_download}" 'sudo apk add --no-cache gpg' \
  "${label_install_script_download}" 'sudo apk add --no-cache git' \
  "${label_install_script_download}" 'sudo apk add --no-cache openssl' \
  "${label_install_script_download}" 'sudo apk add --no-cache python3' \
  "${label_install_script_download}" 'sudo apk add --no-cache tar' \
  "${label_install_script_download}" 'sudo apk add --no-cache unzip' \
  "${label_install_script_download}" 'sudo apk add --no-cache zip' \
  "${label_install_script_download}" 'sudo apk add --no-cache tigervnc' \
  "${label_install_script_download}" 'sudo apk add --no-cache dbus-x11' \
  "${label_install_script_download}" 'sudo apk add --no-cache nano' \
  "${label_install_script_download}" 'sudo apk add --no-cache nautilus' \
  "${label_install_script_download}" 'sudo apk add --no-cache font-manager' \
  "${label_install_script_download}" 'sudo apk add --no-cache evince' \
  "${label_install_script_download}" 'sudo apk add --no-cache firefox' \
  "${label_system_setup}" 'if [ ! -d "$HOME/.config/gtk-3.0" ]; then mkdir -p "$HOME/.config/gtk-3.0"; echo "pasta criada"; fi' \
  "${label_system_setup}" 'echo -e "file:/// raiz\nfile:///sdcard sdcard" | sudo tee $HOME/.config/gtk-3.0/bookmarks'
sleep 2
