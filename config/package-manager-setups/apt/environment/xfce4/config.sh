#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global"
distro_theme="$1"

show_progress_dialog steps-one-label "${label_install_environment_gui}\n\n\n" 13 \
     'sleep 2' \
     'sleep 4' \
     'sleep 6' \
     'sudo apt install xfce4 --no-install-recommends -y' \
     'sudo apt install xfce4-goodies --no-install-recommends -y' \
     'sudo apt install xfce4-terminal --no-install-recommends -y' \
     'sudo apt install xfce4-settings --no-install-recommends -y' \
     'sudo apt install xfce4-panel-profiles --no-install-recommends -y' \
     'sudo apt sudo apt-mark manual ristretto mousepad xfce4-* lib*' \
     'bash -c "cat > $HOME/.local/share/applications/xfce4-keyboard-settings.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Teclado
Comment=Editar preferências de teclado
Exec=xfce4-keyboard-settings
Icon=preferences-desktop-keyboard
Categories=Settings;DesktopSettings;X-XFCE;GTK;
EOF
"' \
     'bash -c "cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
export PULSE_SERVER=127.0.0.1
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
echo $$ > /tmp/xsession.pid
dbus-launch --exit-with-session /usr/bin/startxfce4
EOF
"' \
     'chmod +x ~/.vnc/xstartup' \
     "echo 'export DISPLAY=":1"' >> /etc/profile" \
     'sudo apt --fix-broken install -y'
sleep 2

vncpasswd

sleep 2

if [ "$distro_theme" = "Light" ]; then
    wallpaper="unsplash/square/tiagojose-OhLxeq6DKvI.jpg"
elif [ "$distro_theme" = "Dark" ]; then
    wallpaper="unsplash/square/tiagojose-RiTmt0xGYnA.jpg"
fi


source /etc/profile

show_progress_dialog steps-one-label "${label_config_environment_gui}" 22 \
  "vncserver -name remote-desktop -geometry 1920x1080 :1" \
  "sleep 10" \
  "sleep 4" \
  'xfconf-query -c xsettings -p /Net/ThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
  "sleep 4" \
  'xfconf-query -c xsettings -p /Net/IconThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
  "sleep 4" \
  'xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/${wallpaper}"' \
  'wget --tries=20 "${extralink}/config/package-manager-setups/apt/environment/xfce4/xfce4-panel.tar.bz2"  -O ~/xfce4-panel.tar.bz2 > /dev/null 2>&1' \
  "chmod +x ~/xfce4-panel.tar.bz2" \
  "dbus-launch --exit-with-session xfce4-panel-profiles load xfce4-panel.tar.bz2" \
  "xfce4-panel-profiles load xfce4-panel.tar.bz2" \
  "sleep 4" \
  "firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID" \
  "sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js" \
  'echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js' \
  "sudo apt-get clean" \
  "vncserver -kill :1" \
  "rm -rf /tmp/.X*-lock" \
  "rm -rf /tmp/.X11-unix/X*" \
  "rm -rf ~/start-environment.sh" \
  "rm -rf ~/xfce4-panel.tar.bz2"