#!/bin/bash
timestamp=$(date +'%d%m%Y-%H%M%S')
LOGFILE="/sdcard/termux/andistro/logs/lxde_config_${timestamp}.txt"
#exec > >(tee -a "$LOGFILE") 2>&1
#LXDE config environment
source "/usr/local/bin/global"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 9 \
     'sudo apt install lxde-core --no-install-recommends -y' \
     'sudo apt install lxterminal --no-install-recommends -y' \
     'sudo apt install lxappearance --no-install-recommends -y' \
     'sudo apt install obconf --no-install-recommends -y' \
     'bash -c "cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
export PULSE_SERVER=127.0.0.1
export LANG
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
echo \$\$ > /tmp/xsession.pid
dbus-launch --exit-with-session startlxde
EOF
"' \
     'chmod +x ~/.vnc/xstartup' \
     "echo 'export DISPLAY=":1"' >> /etc/profile" \
     "sudo dpkg --configure -a" \
     "sudo apt --fix-broken install -y" 
sleep 2

vncpasswd

source /etc/profile

show_progress_dialog steps-one-label "${label_config_environment_gui}" 21 \
  'vncserver -name remote-desktop -geometry 1920x1080 :1' \
  'sleep 10' \
  'if [ ! -d "$HOME/.config/lxsession" ];then mkdir -p "$HOME/.config/lxsession"; fi' \
  'if [ ! -d "$HOME/.config/lxsession/LXDE" ];then mkdir -p "$HOME/.config/lxsession/LXDE"; fi' \
  "mkdir -p \$HOME/.config/lxpanel/LXDE" \
  "mkdir -p \$HOME/.config/lxpanel/LXDE/panels" \
  "mkdir -p \$HOME/.config/lxsession/LXDE" \
  "echo -e '[Command]\nLogout=stopvnc' > \$HOME/.config/lxpanel/LXDE/config" \
  "echo -e '# lxpanel <profile> config file. Manually editing is not recommended.\n# Use preference dialog in lxpanel to adjust config when you can.\nGlobal {\n  edge=bottom\n  align=left\n  margin=0\n  widthtype=percent\n  width=100\n  height=54\n  transparent=0\n  tintcolor=#000000\n  alpha=0\n  setdocktype=1\n  setpartialstrut=1\n  autohide=0\n  heightwhenhidden=0\n  usefontcolor=1\n  fontcolor=#ffffff\n  background=0\n  backgroundfile=/usr/share/lxpanel/images/background.png\n  iconsize=48\n  usefontsize=1\n  fontsize=12\n}\nPlugin {\n  type=space\n  Config {\n    Size=20\n  }\n}\nPlugin {\n  type=menu\n  Config {\n    system {\n    }\n    separator {\n    }\n    item {\n      command=run\n    }\n    separator {\n    }\n    item {\n      command=logout\n      image=gnome-logout\n    }\n    image=/usr/share/lxpanel/images/my-computer.png\n  }\n}\nPlugin {\n  type=space\n  Config {\n    Size=20\n  }\n}\nPlugin {\n  type=launchbar\n  Config {\n    Button {\n      id=firefox.desktop\n    }\n  }\n}\nPlugin {\n  type=space\n  Config {\n    Size=20\n  }\n}\nPlugin {\n  type=taskbar\n  Config {\n    IconsOnly=0\n    FlatButton=-1\n    ShowAllDesks=-1\n    UseMouseWheel=-1\n    GroupedTasks=0\n    DisableUpscale=0\n    SameMonitorOnly=0\n  }\n}\nPlugin {\n  type=space\n  Config {\n  }\n  expand=1\n}\nPlugin {\n  type=dclock\n  Config {\n    ClockFmt=%D %R\n    TooltipFmt=%A %x\n    BoldFont=0\n    IconOnly=0\n    CenterText=0\n  }\n}\nPlugin {\n  type=space\n  Config {\n    Size=20\n  }\n}' > \$HOME/.config/lxpanel/LXDE/panels/panel" \
  "echo -e '@lxpanel --profile LXDE\n@pcmanfm --desktop --profile LXDE\n@xscreensaver -no-splash' > \$HOME/.config/lxsession/LXDE/autostart" \
  "echo -e '[Session]\nwindow_manager=openbox-lxde\ndisable_autostart=no\npolkit/command=\nclipboard/command=lxclipboard\nxsettings_manager/command=build-in\nproxy_manager/command=build-in\nkeyring/command=ssh-agent\nquit_manager/command=stopvnc\nlock_manager/command=stopvnc\nterminal_manager/command=lxterminal\nquit_manager/image=/usr/share/lxde/images/logout-banner.png\nquit_manager/layout=top\n\n[GTK]\nsNet/ThemeName=ZorinBlue-${distro_theme}\nsNet/IconThemeName=Zorin\nsGtk/FontName=Sans 10\niGtk/ToolbarStyle=3\niGtk/ButtonImages=1\niGtk/MenuImages=1\niGtk/CursorThemeSize=18\niXft/Antialias=1\niXft/Hinting=1\nsXft/HintStyle=hintslight\nsXft/RGBA=rgb\niNet/EnableEventSounds=1\niNet/EnableInputFeedbackSounds=1\nsGtk/ColorScheme=\niGtk/ToolbarIconSize=3\nsGtk/CursorThemeName=DMZ-White\n\n[Mouse]\nAccFactor=20\nAccThreshold=10\nLeftHanded=0\n\n[Keyboard]\nDelay=500\nInterval=30\nBeep=1\n\n[State]\nguess_default=true\n\n[Dbus]\nlxde=true\n\n[Environment]\nmenu_prefix=lxde-' > \$HOME/.config/lxsession/LXDE/desktop.conf" \
  "echo -e '[Settings]\ngtk-theme-name=ZorinBlue-${distro_theme}\ngtk-icon-theme-name=Zorin\ngtk-font-name=Sans 10\ngtk-cursor-theme-size=18\n gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ\n gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR\n gtk-button-images=1\n gtk-menu-images=1\n gtk-enable-event-sounds=1\n gtk-enable-input-feedback-sounds=1\n gtk-xft-antialias=1\n gtk-xft-hinting=1\n gtk-xft-hintstyle=hintslight\n gtk-xft-rgba=rgb' > \$HOME/.config/gtk-3.0/settings.ini" \
  "sed -i 's|wallpaper=/etc/alternatives/desktop-background|wallpaper=/usr/share/backgrounds/wai-hsuen-chan-DnmMLipPktY.jpg|' ~/.config/pcmanfm/LXDE/desktop-items-0.conf" \
    'firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID' \
  "sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js" \
  'echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js' \
  "sudo apt-get clean" \
  "vncserver -kill :1" \
  "rm -rf /tmp/.X*-lock" \
  "rm -rf /tmp/.X11-unix/X*" \
  "rm -rf ~/start-environment.sh"
sleep 2
