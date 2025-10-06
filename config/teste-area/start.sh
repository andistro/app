#!/bin/bash

apt update

source "/usr/local/bin/global"

show_progress_dialog wget-labeled "${label_progress}" 2 \
	"${label_progress}" -P "/root" "${extralink}/config/teste-area/system-config.sh" \
	"${label_progress}" -P "/root" "${extralink}/config/teste-area/config-environment.sh"

chmod +x /root/system-config.sh
chmod +x /root/config-environment.sh

HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

OPTIONS=(1 "${MENU_theme_select_light}"
		 2 "${MENU_theme_select_dark}")

CHOICE=$(dialog --no-shadow --clear \
                --title "$TITLE" \
                --menu "$MENU_theme_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
	1)	
		echo "Light Theme"
		export distro_theme="Light"
	;;
	2)	
		echo "Dark Theme"
		export distro_theme="Dark"
	;;
esac

# Executa as configurações base do sistema
bash ~/system-config.sh "$distro_theme"

# Configurações da inteface escolhida
bash ~/config-environment.sh "$distro_theme"