#!/bin/bash
distro_theme="$1"
#XFCE4 config environment
source "/usr/local/bin/andistro/global"

show_progress_dialog steps-one-label "${label_install_environment_gui}\n\n\n" 13 \
     'echo "${label_config_environment_gui}"' \
     'sleep 2' \
     'sleep 4' \
     'sleep 6' \
     'sudo apt install xfce4 --no-install-recommends -y' \
     'sudo apt install xfce4-goodies --no-install-recommends -y' \
     'sudo apt install xfce4-terminal --no-install-recommends -y' \
     'sudo apt install xfce4-settings --no-install-recommends -y' \
     'sudo apt install xfce4-panel-profiles --no-install-recommends -y' \
     'bash -c "cat > $HOME/.config/gtk-3.0/gtk.css <<EOF
/* Remove highlight completo e mantém cor branca em todos os estados */
XfdesktopIconView.view .label,
XfdesktopIconView.view .label:backdrop,
XfdesktopIconView.view .label:selected,
XfdesktopIconView.view .label:selected:backdrop {
    background-color: transparent;
    color: #ffffff !important;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8);
}

/* Remove seleção visual dos ícones */
.xfdesktop-icon-view .cell:selected:backdrop,
.xfdesktop-icon-view .cell:selected,
.xfdesktop-icon-view .cell:backdrop {
    background-color: transparent;
}

/* Garante que o texto não mude cor no estado desfocado */
XfdesktopIconView.view {
    color: #ffffff !important;
}
EOF' \
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

show_progress_dialog steps-one-label "${label_config_environment_gui}" 24 \
     'echo "${label_config_environment_gui}"' \
     "sleep 4" \
     'echo "Default Theme: ${distro_theme}"' \
     'echo "Default Wallpaper: /usr/share/backgrounds/${wallpaper}"' \
     'dbus-launch --exit-with-session xfconf-query -c xsettings -p /Net/ThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
     "sleep 4" \
     'dbus-launch --exit-with-session xfconf-query -c xsettings -p /Net/IconThemeName -s AnDistro-Majorelle-Blue-${distro_theme}' \
     "sleep 4" \
     'dbus-launch --exit-with-session xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/${wallpaper}"' \
     'wget --tries=20 "${extralink}/config/package-manager-setups/apt/environment/xfce4/xfce4-panel.tar.bz2"  -O ~/xfce4-panel.tar.bz2' \
     "chmod +x ~/xfce4-panel.tar.bz2" \
     "dbus-launch --exit-with-session xfce4-panel-profiles load xfce4-panel.tar.bz2" \
     "sleep 4" \
     "vncserver -name remote-desktop -geometry 1920x1080 :1" \
     "sleep 10" \
     "dbus-launch --exit-with-session firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID" \
     "sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js" \
     'echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js' \
     "sudo apt-get clean" \
     "vncserver -kill :1" \
     "rm -rf /tmp/.X*-lock" \
     "rm -rf /tmp/.X11-unix/X*" \
     "rm -rf ~/start-environment.sh" \
     "rm -rf ~/xfce4-panel.tar.bz2"