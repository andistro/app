#!/bin/bash
#Gnome Start enviroment
source "/usr/local/bin/global_var_fun.sh"
source /etc/profile

show_progress_dialog steps-one-label "${label_config_environment_gui}" 28 \
	'touch ~/.Xauthority' \
	'vncserver -name remote-desktop -geometry 1920x1080 :1' \
	'sleep 10' \
	'gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/john-towner-JgOeRuGD_Y4.jpg'' \
	'gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/john-towner-JgOeRuGD_Y4.jpg'' \
	'gsettings set org.gnome.desktop.interface color-scheme prefer-dark' \
	'dbus-launch xfconf-query -c xsettings -p /Net/ThemeName -s ZorinBlue-Dark' \
	'gnome-extensions enable dash-to-dock@micxgx.gmail.com' \
	'gsettings set org.gnome.desktop.interface icon-theme "ZorinBlue-Dark"' \
	'gsettings set org.gnome.desktop.interface gtk-theme "ZorinBlue-Dark"' \
	'gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop']"' \
	'gsettings set org.gnome.desktop.session idle-delay 0' \
	'gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0' \
	'gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0' \
	'sudo apt-get remove --purge lilyterm -y' \
	'mv /root/.config/lilyterm/default.conf /root/.config/lilyterm/default.conf.bak' \
	'sudo apt-get autoremove --purge zutty -y' \
	'firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID' \
	"sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js" \
	'echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js' \
	"sudo apt-get clean" \
	'sudo apt-get autoclean' \
	'sudo apt-get autoremove -y' \
	'sudo apt-get purge -y' \
	"vncserver -kill :1" \
	"rm -rf /tmp/.X*-lock" \
	"rm -rf /tmp/.X11-unix/X*" \
	"rm -rf ~/start-environment.sh"