#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
bin="start-debian.sh"
codinome="bookworm"
folder="debian-bookworm"
# Verificar se o idioma do sistema está no mapa, senão usar en-US
if [[ -n "${LANG_CODES[$system_icu_locale_code]}" ]]; then
    system_lang_code="$system_icu_locale_code"
else
    system_lang_code="en-US"
fi

# Montar opções do menu
OPTIONS=()
OPTIONS+=("auto" "→ ${LANG_CODES[$system_lang_code]} $label_detected")
OPTIONS+=("SEP" "────────────")  # Separador visual seguro

# Adicionar os demais idiomas em ordem alfabética (exceto o detectado)
for code in $(printf "%s\n" "${!LANG_CODES[@]}" | sort); do
    [[ "$code" == "$system_lang_code" ]] && continue
    OPTIONS+=("$code" "${LANG_CODES[$code]}")
done

# Tamanho da janela do dialog
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=10

# Mostrar menu com redirecionamento seguro
exec 3>&1
CHOICE=$(dialog --clear \
    --title "$MENU_language_select" \
    --menu "$MENU_language_select" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
    "${OPTIONS[@]}" \
    2>&1 1>&3)
exec 3>&-

clear

# Determinar idioma selecionado
if [[ "$CHOICE" == "auto" || -z "$CHOICE" ]]; then
    language_selected="$system_lang_code"
elif [[ "$CHOICE" == "SEP" ]]; then
    exit 0  # ignorar separador
else
    language_selected="$CHOICE"
fi

# Mostrar idioma escolhido
#dialog --msgbox "$MENU_language_selected $language_selected" 10 70

# Converter de pt-BR para pt_BR
language_transformed="${language_selected//-/_}"

# Exportar, se necessário
export language_selected
export language_transformed

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
	error_code="DW001deb"
	show_progress_dialog wget "${label_debian_download}" 1 -O $folder.tar.xz "${extralink}/distros/files/dists/${archurl}/debian/${codinome}/installer.tar.xz"
	sleep 2
	show_progress_dialog extract "${label_debian_download_extract}" "$HOME/$folder.tar.xz" 
	sleep 2
fi

echo "${label_start_script}"
cat > $bin <<- EOM
#!/bin/bash
#cd \$(dirname \$0)
cd $HOME
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b $folder/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

sed -i "s|command+=\" LANG=C.UTF-8\"|command+=\" LANG=${language_transformed}.UTF-8\"|" "$bin"
error_code="LG001br"
show_progress_dialog "wget" "${label_language_download}" 1 -P "$folder/root/" "${extralink}/config/package-manager-setups/apt/locale/locale_${language_selected}.sh"
sleep 2
chmod +x $folder/root/locale_${language_selected}.sh

echo "127.0.0.1 localhost localhost" > $folder/etc/hosts

# Se não existir, será criado
if [ ! -d "$folder/usr/share/backgrounds/" ];then
	mkdir -p "$folder/usr/share/backgrounds/"
	echo "pasta criada"
fi

if [ ! -d "$folder/usr/share/icons/" ];then
	mkdir -p "$folder/usr/share/icons/"
	echo "pasta criada"
fi

if [ ! -d "$folder/root/.vnc/" ];then
	mkdir -p $folder/root/.vnc/
	echo "pasta criada"
fi

show_progress_dialog wget-labeled "${label_progress}" 10 \
	"${label_progress}" -O "$folder/root/system-config.sh" "${extralink}/config/package-manager-setups/apt/system-config.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/global_var_fun.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/locale/l10n_${language_selected}.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/vnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/vncpasswd" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/startvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/stopvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/startvncserver" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/john-towner-JgOeRuGD_Y4.jpg" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/wai-hsuen-chan-DnmMLipPktY.jpg"

chmod +x $folder/usr/local/bin/vnc
chmod +x $folder/usr/local/bin/vncpasswd
chmod +x $folder/usr/local/bin/startvnc
chmod +x $folder/usr/local/bin/stopvnc
chmod +x $folder/usr/local/bin/startvncserver
chmod +x "$folder/usr/local/bin/global_var_fun.sh"
chmod +x "$folder/usr/local/bin/l10n_${language_selected}.sh"
chmod +x "$folder/root/system-config.sh"
sed -i "s/system_icu_locale_code=.*$/system_icu_locale_code=\"${language_selected}\"/" "$folder/usr/local/bin/global_var_fun.sh"
sleep 2

#Copiando arquivos para dentro do linux

#echo "fixing shebang of $bin"
#termux-fix-shebang $bin
#echo "making $bin executable"
chmod +x $bin

export USER=$(whoami)
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
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
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/lxde/config.sh"
		sleep 2
		;;
	2)	
		echo "XFCE UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/xfce4/config.sh"
		sleep 2
		;;
	3)
		echo "Gnome UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/gnome/config.sh"
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
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin
echo '#!/bin/bash

source "/usr/local/bin/global_var_fun.sh"
#echo "deb http://deb.debian.org/debian stable main contrib non-free non-free-firmware
#deb http://security.debian.org/debian-security stable-security main contrib non-free
#deb http://deb.debian.org/debian stable-updates main contrib non-free
#deb http://ftp.debian.org/debian buster main
#deb http://ftp.debian.org/debian buster-updates main" >> /etc/apt/sources.list

echo "${label_alert_autoupdate_for_u}"


#======================================================================================================
# global_var_fun.sh == update_progress() {}

total_steps=5
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
#======================================================================================================

echo "$system_timezone" | sudo tee /etc/timezone > /dev/null 2>&1
sudo ln -sf "/usr/share/zoneinfo/$system_timezone" /etc/localtime

clear
chmod +x /usr/local/bin/vnc
chmod +x /usr/local/bin/vncpasswd
chmod +x /usr/local/bin/startvnc
chmod +x /usr/local/bin/stopvnc
chmod +x /usr/local/bin/startvncserver

bash ~/locale_${system_icu_locale_code}.sh

apt update -y > /dev/null 2>&1

bash ~/system-config.sh

clear

bash ~/config-environment.sh

if [ ! -e "~/start-environment.sh" ];then
	bash ~/start-environment.sh
fi

show_progress_dialog check-packages "Verificando todos os pacotes globais instalados..." \
	sudo xz-utils firefox code bleachbit at-spi2-core gvfs-backends synaptic evince font-manager \
	nautilus inetutils-tools nano dbus-x11 tigervnc-tools tigervnc-common tigervnc-standalone-server \
	exo-utils apt-utils python3-gi python3 tar zip unzip curl gpg git dialog wget locales language-pack-pt-base \
	keyboard-configuration tzdata 

rm -rf ~/locale*.sh
rm -rf ~/.bash_profile
rm -rf ~/.hushlogin' > $folder/root/.bash_profile 

# Cria uma gui de inicialização
sed -i '\|command+=" /bin/bash --login"|a command+=" -b /usr/local/bin/startvncserver"' $bin
cp "$bin" "$PREFIX/bin/${bin%.sh}" #isso permite que o comando seja iniciado sem o uso do bash ou ./
rm -rf $HOME/distrolinux-install.sh
rm -rf $HOME/start-distro.sh
bash $bin