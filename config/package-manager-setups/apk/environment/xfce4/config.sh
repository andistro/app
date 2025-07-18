#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global_var_fun.sh"
mkdir -p "$HOME/.vnc"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 19 \
     'sudo apk add --no-cache xfce4' \
     'sudo apk add --no-cache xfce4-terminal' \
     'sudo apk add --no-cache xfce4-appfinder' \
     'bash -c "cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
export PULSE_SERVER=127.0.0.1
export LANG
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
echo $$ > /tmp/xsession.pid
startxfce4
EOF
"' \
     'chmod +x /usr/local/bin/vnc' \
     "echo 'export DISPLAY=":1"' >> /etc/profile" \
     "wget --tries=20 '${extralink}/config/package-manager-setups/apt/environment/xfce4/start-environment.sh'" \
     '[ -f ~/start-environment.sh ] && chmod +x ~/start-environment.sh' \
     'sudo dpkg --configure -a' \
     'sudo apt --fix-broken install -y'
sleep 2

vncpasswd