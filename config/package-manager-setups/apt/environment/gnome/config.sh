#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
# GNOME Config
show_progress_dialog steps-one-label "${label_install_environment_gui}" 27 \
	'sudo apt-get install gdm3 --no-install-recommends -y' \
	'sudo apt-get install policykit-1 --no-install-recommends -y' \
	'sudo apt-get install gnome-session --no-install-recommends -y' \
	'sudo apt-get install gnome-shell --no-install-recommends -y' \
	'sudo apt-get install gnome-terminal --no-install-recommends -y' \
	'sudo apt-get install gnome-tweaks --no-install-recommends -y' \
	'sudo apt-get install gnome-control-center --no-install-recommends -y' \
	'sudo apt-get install gnome-shell-extensions --no-install-recommends -y' \
	'sudo apt-get install gnome-shell-extension-dashtodock --no-install-recommends -y' \
	'sudo apt-get install gnome-package-updater --no-install-recommends -y' \
	'sudo apt-get install gnome-calculator --no-install-recommends -y' \
	'sudo apt-get install lsb-release --no-install-recommends -y' \
	'sudo apt-get install dconf-cli --no-install-recommends -y' \
	'sudo apt-get install exo-utils --no-install-recommends -y' \
	'sudo apt-get install tigervnc-standalone-server --no-install-recommends -y' \
	'sudo apt-get install tigervnc-common --no-install-recommends -y' \
	'sudo apt-get install tigervnc-tools --no-install-recommends -y' \
	'sudo apt-get install dbus-x11 --no-install-recommends -y' \
	'sudo apt install python3-gi -y' \
	'sudo apt install python3 -y' \
	'bash -c "cat > $HOME/.vnc/xstartup <<EOF
#!/bin/bash
export LANG
export PULSE_SERVER=127.0.0.1
gnome-shell --x11
EOF
"' \
	'chmod +x ~/.vnc/xstartup' \
	"echo 'export DISPLAY=":1"' >> /etc/profile" \
	"wget --tries=20 '${extralink}/config/package-manager-setups/apt/environment/gnome/start-environment.sh'" \
	"[ -f ~/start-environment.sh ] && chmod +x ~/start-environment.sh" \
	"sudo dpkg --configure -a" \
	"sudo apt --fix-broken install -y" 
sleep 2


vncpasswd