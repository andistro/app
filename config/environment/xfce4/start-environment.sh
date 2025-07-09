#!/bin/bash
#XFCED4 start environment
source "/usr/local/bin/global_var_fun.sh"
source /etc/profile

show_progress_dialog steps-one-label "${label_config_environment_gui}" 25 \
  'vncserver -name remote-desktop -geometry 1920x1080 :1' \
  'sleep 10' \
  'xfce4-session > /dev/null 2>&1 &' \
  'sleep 4' \
  'xfconf-query -c xsettings -p /Net/ThemeName -s ZorinBlue-Dark' \
  'dbus-launch xfconf-query -c xsettings -p /Net/ThemeName -s ZorinBlue-Dark' \
  'sleep 4' \
  'xfconf-query -c xsettings -p /Net/IconThemeName -s ZorinBlue-Dark' \
  'dbus-launch xfconf-query -c xsettings -p /Net/IconThemeName -s ZorinBlue-Dark' \
  'sleep 4' \
  'xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/wai-hsuen-chan-DnmMLipPktY.jpg"' \
  "sed -i 's|/usr/share/backgrounds/xfce/xfce-verticals.png|/usr/share/backgrounds/wai-hsuen-chan-DnmMLipPktY.jpg|' \"\$HOME/.config/xfce4/xfce-perchannel-xml/xfce4-desktop.xml\"" \
  'wget --tries=20 "${extralink}/config/environment/xfce4/xfce4-panel.tar.bz2"  -O ~/xfce4-panel.tar.bz2 > /dev/null 2>&1' \
  'chmod +x ~/xfce4-panel.tar.bz2' \
  'xfce4-panel-profiles load xfce4-panel.tar.bz2' \
  'dbus-launch --exit-with-session xfce4-panel-profiles load xfce4-panel.tar.bz2' \
  'sleep 4' \
  "firefox > /dev/null 2>&1 & PID=\$(pidof firefox); sleep 5; kill \$PID" \
  "sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js"\
  "echo 'user_pref("security.sandbox.content.level", 0);' >> ~/.mozilla/firefox/*.default-release/prefs.js" \
  "sudo apt-get clean" \
  "vncserver -kill :1" \
  "rm -rf /tmp/.X*-lock" \
  "rm -rf /tmp/.X11-unix/X*" \
  "rm -rf ~/start-environment.sh"
