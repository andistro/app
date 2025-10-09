#!/bin/bash
source "/usr/local/bin/andistro/global"
# GNOME Config
show_progress_dialog steps-one-label "${label_install_environment_gui}" 21 \
	'sleep 1' \
	'sleep 10' \
	'sudo apt install gnome-session --no-install-recommends -y' \
	'sudo apt install gnome-shell --no-install-recommends -y' \
	'sudo apt install gnome-terminal --no-install-recommends -y' \
	'sudo apt install gnome-tweaks --no-install-recommends -y' \
	'sudo apt install gnome-control-center --no-install-recommends -y' \
	'sudo apt install gnome-shell-extensions --no-install-recommends -y' \
	'sudo apt install gnome-shell-extension-dashtodock --no-install-recommends -y' \
	'sudo apt install gnome-package-updater --no-install-recommends -y' \
	'sudo apt install gnome-calculator --no-install-recommends -y' \
	'sudo apt install xterm --no-install-recommends -y' \
  	'sudo apt install xorg --no-install-recommends -y' \
  	'sudo apt install at-spi2-core --no-install-recommends -y' \
  	'sudo apt install dconf-cli --no-install-recommends -y' \
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