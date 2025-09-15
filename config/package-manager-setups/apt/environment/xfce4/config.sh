#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 14 \
     'sleep 2' \
     'sleep 4' \
     'sleep 6' \
     'sudo apt install xfce4 --no-install-recommends -y' \
     'sudo apt install xfce4-goodies --no-install-recommends -y' \
     'sudo apt install xfce4-terminal --no-install-recommends -y' \
     'sudo apt install xfce4-panel-profiles --no-install-recommends -y' \
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
     "wget --tries=20 '${extralink}/config/package-manager-setups/apt/environment/xfce4/start-environment.sh'" \
     '[ -f ~/start-environment.sh ] && chmod +x ~/start-environment.sh' \
     'sudo dpkg --configure -a' \
     'sudo apt --fix-broken install -y'
sleep 2

vncpasswd

