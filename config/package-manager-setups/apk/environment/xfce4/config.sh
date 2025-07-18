#!/bin/bash
#XFCE4 config environment
source "/usr/local/bin/global_var_fun.sh"
mkdir -p "$HOME/.vnc"

show_progress_dialog steps-one-label "${label_install_environment_gui}" 3 \
     'sudo apk add --no-cache xfce4' \
     'sudo apk add --no-cache xfce4-terminal' \
     'sudo apk add --no-cache xfce4-appfinder'
sleep 2

vncpasswd