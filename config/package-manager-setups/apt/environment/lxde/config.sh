#!/bin/bash
#LXDE config environment
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 8 \
     'sudo apt-get install lxde-core --no-install-recommends -y' \
     'sudo apt-get install lxterminal --no-install-recommends -y' \
     'sudo apt-get install lxappearance --no-install-recommends -y' \
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
