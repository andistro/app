#!/bin/bash
distro_theme="$1"

dialog --no-shadow --msgbox "Teste area script executed with theme: $distro_theme" 8 40
#XFCE4 config environment
source "/usr/local/bin/global"

if [ "$distro_theme" = "Light" ]; then
    wallpaper="unsplash/square/tiagojose-OhLxeq6DKvI.jpg"
elif [ "$distro_theme" = "Dark" ]; then
    wallpaper="unsplash/square/tiagojose-RiTmt0xGYnA.jpg"
fi

show_progress_dialog steps-one-label "${label_config_environment_gui}" 8 \
  'xfconf-query -c xsettings -p /Net/ThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
  "sleep 4" \
  'xfconf-query -c xsettings -p /Net/IconThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
  "sleep 4" \
  'xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/${wallpaper}"' \
  'wget --tries=20 "${extralink}/config/package-manager-setups/apt/environment/xfce4/xfce4-panel.tar.bz2"  -O ~/xfce4-panel.tar.bz2' \
  "chmod +x ~/xfce4-panel.tar.bz2" \
  "xfce4-panel-profiles load xfce4-panel.tar.bz2" \

