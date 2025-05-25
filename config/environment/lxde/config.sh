#!/bin/bash
#LXDE config environment
source "/usr/local/bin/fixed_variables.sh"

show_progress_dialog steps-one-label 17 \
     "${label_install_environment_gui}" 'sudo apt-get install lxde-core --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install lxterminal --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install lxappearance --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install exo-utils --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install tigervnc-standalone-server --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install tigervnc-common --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install tigervnc-tools --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt-get install dbus-x11 --no-install-recommends -y' \
     "${label_install_environment_gui}" 'sudo apt install python3-gi -y' \
     "${label_install_environment_gui}" 'sudo apt install python3 -y' \
     "${label_install_environment_gui}" "echo -e '#!/bin/bash\n[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources\nexport PULSE_SERVER=127.0.0.1\nexport LANG\n[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup\n[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources\necho \$\$ > /tmp/xsession.pid\ndbus-launch --exit-with-session startlxde' > ~/.vnc/xstartup" \
     "${label_install_environment_gui}" 'chmod +x ~/.vnc/xstartup' \
     "${label_install_environment_gui}" "echo 'export DISPLAY=":1"' >> /etc/profile" \
     "${label_install_environment_gui}" "wget --tries=20 '${extralink}/config/environment/lxde/start-environment.sh'" \
     "${label_install_environment_gui}" "[ -f ~/start-environment.sh ] && chmod +x ~/start-environment.sh" \
     "${label_install_environment_gui}" "sudo dpkg --configure -a" \
     "${label_install_environment_gui}" "sudo apt --fix-broken install -y" 
sleep 10

vncpasswd


