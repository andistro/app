#!/bin/bash
distro_theme="$1"
#LXDE config environment
source "/usr/local/lib/andistro/global"

echo -e "\033[1;96m$label_install_environment_gui\033[0m"
echo " "
sleep 2

sudo apt install --no-install-recommends -y \
    lxde-core \
    lxterminal \
    lxappearance \
    obconf


cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
export PULSE_SERVER=127.0.0.1
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
echo \$\$ > /tmp/xsession.pid
dbus-launch --exit-with-session startlxde
EOF

chmod +x $HOME/.vnc/xstartup
echo 'export DISPLAY=":1"' >> /etc/profile
sudo dpkg --configure -a
sudo apt --fix-broken install -y

sleep 2

andistro --boot vnc --passwd
sleep 2
source /etc/profile


if [ "$distro_theme" = "Light" ]; then
    wallpaper="andistro/andistro-light.jpg"
elif [ "$distro_theme" = "Dark" ]; then
    wallpaper="andistro/andistro-dark.jpg"
fi

echo -e "\033[1;96m$label_config_environment_gui\033[0m"
echo " "
sleep 2

mkdir -p "$HOME/.config/lxsession"
mkdir -p "$HOME/.config/lxsession/LXDE"
mkdir -p "$HOME/.config/lxpanel/LXDE"
mkdir -p "$HOME/.config/lxpanel/LXDE/panels"
mkdir -p "$HOME/.config/lxsession/LXDE"

echo -e '[Command]
Logout=andistro --boot vnc --kill' > $HOME/.config/lxpanel/LXDE/config
echo -e '# lxpanel <profile> config file. Manually editing is not recommended.
# Use preference dialog in lxpanel to adjust config when you can.
Global {
    edge=bottom
    align=left
    margin=0
    widthtype=percent
    width=100
    height=54
    transparent=0
    tintcolor=#000000
    alpha=0
    setdocktype=1
    setpartialstrut=1
    autohide=0
    heightwhenhidden=0
    usefontcolor=1
    fontcolor=#ffffff
    background=0
    backgroundfile=/usr/share/lxpanel/images/background.png
    iconsize=48
    usefontsize=1
    fontsize=12\n
}
Plugin {
    type=space
    Config {
        Size=20
    }
}
Plugin {
    type=menu
    Config {
        system { }
        separator { }
        item {
            command=run
        }
        separator { }
        item {
            command=logout
            image=gnome-logout
        }
        image=/usr/share/lxpanel/images/my-computer.png
    }
}
Plugin {
    type=space
    Config {
        Size=20
    }
}
Plugin {
    type=launchbar
    Config {
        Button {
            id=firefox.desktop
        }
    }
}
Plugin {
    type=space
    Config {
        Size=20
    }
}
Plugin {
    type=taskbar
    Config {
        IconsOnly=0
        FlatButton=-1
        ShowAllDesks=-1
        UseMouseWheel=-1
        GroupedTasks=0
        DisableUpscale=0
        SameMonitorOnly=0
    }
}
Plugin {
    type=space
    Config { }
    expand=1
}
Plugin {
    type=dclock
    Config {
        ClockFmt=%D %R
        TooltipFmt=%A %x
        BoldFont=0
        IconOnly=0
        CenterText=0
    }
}
Plugin {
    type=space
    Config {
        Size=20
    }
}' > $HOME/.config/lxpanel/LXDE/panels/panel

echo -e '@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
@xscreensaver -no-splash' > $HOME/.config/lxsession/LXDE/autostart

echo -e "[Session]
window_manager=openbox-lxde
disable_autostart=no
polkit/command=
clipboard/command=lxclipboard
xsettings_manager/command=build-in
proxy_manager/command=build-in
keyring/command=ssh-agent
quit_manager/command=andistro --boot vnc --kill
lock_manager/command=andistro --boot vnc --kill
terminal_manager/command=lxterminal
quit_manager/image=/usr/share/lxde/images/logout-banner.png
quit_manager/layout=top

[GTK]
sNet/ThemeName=AnDistro-Majorelle-Blue-${distro_theme}
sNet/IconThemeName=ZorinBlue-${distro_theme}
sGtk/FontName=Sans 10
iGtk/ToolbarStyle=3
iGtk/ButtonImages=1
iGtk/MenuImages=1
iGtk/CursorThemeSize=18
iXft/Antialias=1
iXft/Hinting=1
sXft/HintStyle=hintslight
sXft/RGBA=rgb
iNet/EnableEventSounds=1
iNet/EnableInputFeedbackSounds=1
sGtk/ColorScheme=
iGtk/ToolbarIconSize=3
sGtk/CursorThemeName=DMZ-White

[Mouse]
AccFactor=20
AccThreshold=10
LeftHanded=0

[Keyboard]
Delay=500
Interval=30
Beep=1

[State]
guess_default=true
[Dbus]lxde=true

[Environment]
menu_prefix=lxde-" > $HOME/.config/lxsession/LXDE/desktop.conf

echo -e "[Settings]
gtk-theme-name=AnDistro-Majorelle-Blue-${distro_theme}
gtk-icon-theme-name=ZorinBlue-${distro_theme}
gtk-font-name=Sans 10
gtk-cursor-theme-size=18
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb" > $HOME/.config/gtk-3.0/settings.ini

sed -i "s|wallpaper=/etc/alternatives/desktop-background|wallpaper=/usr/share/backgrounds/${wallpaper}|" $HOME/.config/pcmanfm/LXDE/desktop-items-0.conf

