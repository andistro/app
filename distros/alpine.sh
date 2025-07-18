#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
bin="start-alpine.sh"
codinome="edge"
folder="alpine-edge"
binds="alpine-binds"

#=============================================================================================
# Caso a versão do debian já tenha sido baixada, não baixar novamente
if [ -d "$folder" ]; then
	first=1
	echo "${label_skip_download}"
fi

sleep 2
# Baixa
if [ "$first" != 1 ];then
	case `dpkg --print-architecture` in
	aarch64)
		archurl="arm64" ;;
	arm)
		archurl="armhf" ;;
	*)
		echo "unknown architecture"; exit 1 ;;
	esac
	show_progress_dialog wget "${label_alpine_download}" 1 -O $folder.tar.xz "${extralink}/distros/files/dists/${archurl}/alpine/${codinome}/installer.tar.xz"
	sleep 2
	show_progress_dialog extract "${label_alpine_download_extract}" "$HOME/$folder.tar.xz"
	sleep 2
fi

cat > $bin <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash
	cd \$(dirname \$0)
	## unset LD_PRELOAD in case termux-exec is installed
	unset LD_PRELOAD
	command="proot"
	command+=" --link2symlink"
	command+=" -0"
	command+=" -r $folder"
	command+=" -b /dev"
	command+=" -b /proc"
	command+=" -b $folder/root:/dev/shm"
	## uncomment the following line to have access to the home directory of termux
	#command+=" -b /data/data/com.termux/files/home:/root"
	## uncomment the following line to mount /sdcard directly to /
	#command+=" -b /sdcard"
	command+=" -w /root"
	command+=" /usr/bin/env -i"
	command+=" HOME=/root"
	command+=" PATH=/bin:/usr/bin:/sbin:/usr/sbin"
	command+=" TERM=\$TERM"
	command+=" LANG=en_US.UTF-8"
	command+=" LC_ALL=C"
	command+=" LANGUAGE=en_US"
	command+=" /bin/sh --login"
	com="\$@"
	if [ -z "\$1" ];then
    		exec \$command
	else
    		\$command -c "\$com"
	fi
	EOM

chmod +x $bin

echo "" > $folder/etc/fstab
rm -rf $folder/etc/resolv.conf
echo nameserver 8.8.8.8 > $folder/etc/resolv.conf
mkdir -p $folder/usr/local/bin
mkdir -p $folder/usr/share/backgrounds
show_progress_dialog wget-labeled "${label_progress}" 9 \
	"${label_progress}" -P "$folder/root" "${extralink}/config/package-manager-setups/apk/system-config.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/global_var_fun.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/tigervnc/vnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/tigervnc/vncpasswd" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/tigervnc/startvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/tigervnc/stopvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/tigervnc/startvncserver" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/john-towner-JgOeRuGD_Y4.jpg" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/wai-hsuen-chan-DnmMLipPktY.jpg"
sleep 2
chmod +x "$folder/root/system-config.sh"
chmod +x "$folder/usr/local/bin/vnc"
chmod +x "$folder/usr/local/bin/vncpasswd"
chmod +x "$folder/usr/local/bin/startvnc"
chmod +x "$folder/usr/local/bin/stopvnc"
chmod +x "$folder/usr/local/bin/startvncserver"
chmod +x "$folder/usr/local/bin/global_var_fun.sh"

export USER=$(whoami)
export PORT=1
OPTIONS=(1 "LXDE"
		 2 "XFCE"
		 3 "Gnome")

CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --menu "$MENU_environments_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
	1)	
		echo "LXDE UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/environment/lxde/config.sh"
		sleep 2
		;;
	2)	
		echo "XFCE UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/environment/xfce4/config.sh"
		sleep 2
		;;
	3)
		echo "Gnome UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/environment/gnome/config.sh"
		sleep 2
		# Parte da resolução do problema do gnome e do systemd
		if [ ! -d "/data/data/com.termux/files/usr/var/run/dbus" ];then
			mkdir /data/data/com.termux/files/usr/var/run/dbus # criar a pasta que o dbus funcionará
			echo "pasta criada"
		fi
		#mkdir /data/data/com.termux/files/usr/var/run/dbus # criar a pasta que o dbus funcionará
		rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid #remover o pid para que o dbus-daemon funcione corretamente
		rm -rf system_bus_socket

		dbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket #cria o arquivo

		if grep -q "<listen>tcp:host=localhost" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<listen>unix:tmpdir=/tmp</listen>" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<auth>ANONYMOUS</auth>" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<allow_anonymous/>" /data/data/com.termux/files/usr/share/dbus-1/system.conf; then # verifica se existe a linha com esse texto
		echo ""
			else
				sed -i 's|<auth>EXTERNAL</auth>|<listen>tcp:host=localhost,bind=*,port=6667,family=ipv4</listen>\
				<listen>unix:tmpdir=/tmp</listen>\
				<auth>EXTERNAL</auth>\
				<auth>ANONYMOUS</auth>\
				<allow_anonymous/>|' /data/data/com.termux/files/usr/share/dbus-1/system.conf
		fi

		# É necessário repetir o processo toda vez que alterar o system.conf
		rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid
		dbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket
		sed -i "\|command+=\" -b $folder/root:/dev/shm\"|a command+=\" -b system_bus_socket:/run/dbus/system_bus_socket\"" $bin
		sed -i '1 a\rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid \ndbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket\n' $bin
	;;
esac
clear

chmod +x $folder/root/config-environment.sh

sleep 4

touch $folder/root/.hushlogin
bash $bin apk update > /dev/null 2>&1
bash $bin apk add --no-cache bash > /dev/null 2>&1

sed -i 's/ash/bash/g' $folder/etc/passwd
sed -i 's/bin\/sh/bin\/bash/g' $bin
echo '#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"

update_progress() {
    local current_step=$1
    local total_steps=$2
    local percent=$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=$((percent * bar_length / 100))
    local empty_length=$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=$(printf "%${filled_length}s" | tr " " "=")
    empty_bar=$(printf "%${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

total_steps=6
current_step=0

apk update > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

apk add --no-cache bash > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

apk add --no-cache sudo > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando sudo"
sleep 0.5

apk add --no-cache grep > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

apk add --no-cache wget > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando wget"
sleep 0.5

apk add --no-cache dialog > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt


rm -rf ~/.bash_profile
rm -rf ~/.hushlogin' > $folder/root/.bash_profile 

bash $bin