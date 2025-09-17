#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global_var_fun.sh"

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
export LANG
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

show_progress_dialog steps-one-label "${label_config_environment_gui}" 22 \
  'vncserver -name remote-desktop -geometry 1920x1080 :1' \
  'sleep 10' \
  'xfce4-session > /dev/null 2>&1 &' \
  'sleep 4' \
  'dbus-launch xfconf-query -c xsettings -p /Net/ThemeName -s ZorinBlue-Dark' \
  'sleep 4' \
  'dbus-launch xfconf-query -c xsettings -p /Net/IconThemeName -s ZorinBlue-Dark' \
  'sleep 4' \
  'xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/wai-hsuen-chan-DnmMLipPktY.jpg"' \
  'wget --tries=20 "${extralink}/config/package-manager-setups/apt/environment/xfce4/xfce4-panel.tar.bz2"  -O ~/xfce4-panel.tar.bz2 > /dev/null 2>&1' \
  'chmod +x ~/xfce4-panel.tar.bz2' \
  'dbus-launch --exit-with-session xfce4-panel-profiles load xfce4-panel.tar.bz2' \
  'sleep 4' \
  'firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID' \
  "sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js" \
  'echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js' \
  "sudo apt-get clean" \
  "vncserver -kill :1" \
  "rm -rf /tmp/.X*-lock" \
  "rm -rf /tmp/.X11-unix/X*" \
  "rm -rf ~/start-environment.sh" \
  "rm -rf ~/xfce4-panel.tar.bz2"

# root@localhost:~# sudo apt install xfce4 xfce4-terminal xfce4-panel-profiles --no-install-recommends -y
# Instalando:                                            xfce4  xfce4-panel-profiles  xfce4-terminal
#                                                      Instalando dependências:
#   cpp                                                  cpp-14
#   cpp-14-aarch64-linux-gnu                             cpp-aarch64-linux-gnu
#   gir1.2-libxfce4ui-2.0                                gir1.2-libxfce4util-1.0
#   libdbusmenu-glib4                                    libdbusmenu-gtk3-4                                   libdisplay-info2                                     libgarcon-1-0                                        libgarcon-common                                     libgarcon-gtk3-1-0                                   libgtk-layer-shell0                                  libgtop-2.0-11                                       libgtop2-common                                      libisl23                                             libkeybinder-3.0-0
#   libmpc3                                              libpulse-mainloop-glib0
#   libthunarx-3-0                                       libutempter0
#   libwnck-3-0                                          libwnck-3-common                                     libxaw7                                              libxfce4panel-2.0-4                                  libxfce4ui-utils                                     libxfce4windowing-0-0                                libxfce4windowing-common                             libxkbfile1                                          libxklavier16                                        libxmu6                                              libxmuu1                                             libxpresent1                                         libxres1
#   libxt6t64                                            python3-psutil
#   thunar                                               thunar-data
#   x11-xkb-utils                                        x11-xserver-utils                                    xfce4-appfinder                                      xfce4-helpers                                        xfce4-panel                                          xfce4-pulseaudio-plugin
#   xfce4-session                                        xfce4-settings
#   xfdesktop4                                           xfdesktop4-data
#   xfwm4                                              
# Pacotes sugeridos:                                     cpp-doc                   cairo-5c
#   gcc-14-locales            xorg-docs-core             cpp-14-doc                xfce4-goodies
#   thunar-archive-plugin     xfce4-power-manager        thunar-media-tags-plugin  sensible-utils             nickle                    fortune-mod                                                                   Pacotes recomendados:                                  policykit-1-gnome      | pipewire-pulse
#   | polkit-1-auth-agent  libglib2.0-bin                thunar-volman          light-locker
#   tumbler                | xfce4-screensaver           xdg-user-dirs          | xscreensaver
#   desktop-base           | mate-screensaver            mate-polkit            upower                        tango-icon-theme       colord                        xfce4-notifyd          x11-utils                     xorg                   xiccd                         pavucontrol            librsvg2-common
#   pulseaudio                                         

