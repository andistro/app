#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 19 \
     'sudo apk add --no-cache xfce4' \
     'sudo apk add --no-cache xfce4-terminal' \
     'sudo apk add --no-cache xfce4-appfinder' \
     'bash -c "cat > /usr/local/bin/vnc <<EOF
#!/bin/bash
export DISPLAY=$DISPLAY
/usr/bin/Xvfb $DISPLAY -screen 0 $RESOLUTION -ac +extension GLX +render -noreset & 
sleep 2 && startxfce4 &
sleep 2 && x11vnc -xkb -noxrecord -noxfixes -noxdamage -display $DISPLAY -forever -bg -rfbauth /root/.vnc/passwd -users root -rfbport 5901 -noshm &
echo 'Connect to localhost:1 with a VNC client'
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