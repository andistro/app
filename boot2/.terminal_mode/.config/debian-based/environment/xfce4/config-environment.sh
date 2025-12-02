#!/bin/bash
export distro_theme="$1"
#XFCE4 config environment
source "/usr/local/lib/andistro/global"

echo -e "\033[1;96m$label_install_environment_gui\033[0m"
echo " "
sleep 2

sudo apt install --no-install-recommends -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    xfce4-settings \
    xfce4-panel-profiles

cat > $HOME/.config/gtk-3.0/gtk.css <<EOF
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
EOF

cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
export PULSE_SERVER=127.0.0.1
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
echo $$ > /tmp/xsession.pid
dbus-launch --exit-with-session /usr/bin/startxfce4
EOF

chmod +x $HOME/.vnc/xstartup

echo 'export DISPLAY=":1"' >> /etc/profile

sudo dpkg --configure -a 
sudo apt --fix-broken install -y

andistro --boot vnc --passwd

sleep 2

if [ "$distro_theme" = "Light" ]; then
    wallpaper="andistro/andistro-light.jpg"
elif [ "$distro_theme" = "Dark" ]; then
    wallpaper="andistro/andistro-dark.jpg"
fi

source /etc/profile

echo -e "\033[1;96m$label_config_environment_gui\033[0m"
echo " "
sleep 2

export DISPLAY=:1

dbus-launch --exit-with-session xfce4-panel-profiles load xfce4-panel.tar.bz2

dbus-launch --exit-with-session xfconf-query --channel xfwm4 --property /general/use_compositing --create -t bool -s false

dbus-launch --exit-with-session xfconf-query --channel xfwm4 --property /general/use_compositing --set false

dbus-launch --exit-with-session xfconf-query --channel xfwm4 --property /general/theme --set AnDistro-Majorelle-Blue-${distro_theme}

dbus-launch --exit-with-session xfconf-query --channel xsettings --property /Net/ThemeName --set AnDistro-Majorelle-Blue-${distro_theme}

dbus-launch --exit-with-session xfconf-query --channel xsettings --property /Net/IconThemeName --set ZorinBlue-${distro_theme}

dbus-launch --exit-with-session xfconf-query --channel xfce4-desktop --create --type string --property /backdrop/screen0/monitorVNC-0/workspace0/last-image --create --type string --set "/usr/share/backgrounds/${wallpaper}"

dbus-launch --exit-with-session xfconf-query --channel xfce4-desktop --create --type string --property /backdrop/screen0/monitor0/image-path --set "/usr/share/backgrounds/${wallpaper}"

dbus-launch --exit-with-session xfdesktop --reload

dbus-launch --exit-with-session xfce4-panel --restart

grep -q "<property name=\"last-image\" type=\"string\" value=\"/usr/share/backgrounds/\"/>" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml" && grep -q "<property name=\"image-path\" type=\"string\" value=\"/usr/share/backgrounds/\"/>" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"sed -i -e "s|<property name=\"last-image\" type=\"string\" value=\"/usr/share/backgrounds/\"/>|<property name=\"last-image\" type=\"string\" value=\"/usr/share/backgrounds/'"${wallpaper}"'\"/>|g" -e "s|<property name=\"image-path\" type=\"string\" value=\"/usr/share/backgrounds/\"/>|<property name=\"image-path\" type=\"string\" value=\"/usr/share/backgrounds/'"${wallpaper}"'\"/>|g" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

grep -q "<property name=\"ThemeName\" type=\"empty\"/>" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" && sed -i "s|<property name=\"ThemeName\" type=\"empty\"/>|<property name=\"ThemeName\" type=\"string\" value=\"AnDistro-Majorelle-Blue-'"${distro_theme}"'\"/>|g" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"

grep -q "<property name=\"IconThemeName\" type=\"empty\"/>" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" && sed -i "s|<property name=\"IconThemeName\" type=\"empty\"/>|<property name=\"IconThemeName\" type=\"string\" value=\"ZorinBlue-'"${distro_theme}"'\"/>|g" "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"