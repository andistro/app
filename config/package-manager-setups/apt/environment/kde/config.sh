#!/bin/bash
#LXDE config environment
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 14 \
     'sudo apt-get install plasma-desktop --no-install-recommends -y' \
     'sudo apt-get install plasma-workspace --no-install-recommends -y' \
     'sudo apt-get install kwin-data --no-install-recommends -y' \
     'sudo apt-get install kwin-x11 --no-install-recommends -y' \
     'sudo apt-get install kde-plasma-addons-data --no-install-recommends -y' \
     'sudo apt-get install kde-plasma-desktop --no-install-recommends -y' \
     'sudo apt-get install kde-standard --no-install-recommends -y' \
     'bash -c "cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
export PULSE_SERVER=127.0.0.1
export LANG
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
echo \$\$ > /tmp/xsession.pid
dbus-launch --exit-with-session startplasma-x11
EOF
"' \
     'chmod +x ~/.vnc/xstartup' \
     "echo 'export DISPLAY=":1"' >> /etc/profile" \
     "wget --tries=20 '${extralink}/config/package-manager-setups/apt/environment/kde/start-environment.sh'" \
     "[ -f ~/start-environment.sh ] && chmod +x ~/start-environment.sh" \
     "sudo dpkg --configure -a" \
     "sudo apt --fix-broken install -y" 
sleep 2

vncpasswd
