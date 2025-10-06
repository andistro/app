#!/bin/bash
distro_theme="$1"

dialog --no-shadow --msgbox "Teste area script executed with theme: $distro_theme" 8 40
#XFCE4 config environment
source "/usr/local/bin/global"

show_progress_dialog steps-multi-label 10 \
    "${label_system_setup}" "echo -e '[Settings]\\ngtk-theme-name=AnDistro-Majorelle-Blue-${distro_theme}' | sudo tee $HOME/.config/gtk-3.0/settings.ini" \
    "${label_system_setup}" "echo 'gtk-theme-name=\"AnDistro-Majorelle-Blue-${distro_theme}\"' | sudo tee $HOME/.gtkrc-2.0"