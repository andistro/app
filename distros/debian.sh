#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
distro_name="debian"
bin="$PREFIX/bin/andistro_files/boot/start-$distro_name"
codinome="trixie"
andistro_files="$PREFIX/bin/andistro_files"
folder="$PREFIX/bin/andistro_files/boot/$distro_name/$codinome"

if [ ! -d "$PREFIX/bin/andistro_files/boot/$distro_name" ];then
    mkdir -p "$PREFIX/bin/andistro_files/boot/$distro_name"
fi

if [ ! -d "$HOME/storage/shared/termux/andistro/boot" ];then
    mkdir -p "$HOME/storage/shared/termux/"
    mkdir -p "$HOME/storage/shared/termux/andistro"
    mkdir -p "$HOME/storage/shared/termux/andistro/boot"
    mkdir -p "$HOME/storage/shared/termux/andistro/boot/$distro_name/$codinome"
fi

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
CHOICE=$(dialog --no-shadow --clear \
    --title "$MENU_language_select" \
    --menu "$MENU_language_select" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
    "${OPTIONS[@]}" \
    2>&1 1>&3)
exec 3>&-


# Determinar idioma selecionado
if [[ "$CHOICE" == "auto" || -z "$CHOICE" ]]; then
    language_selected="$system_lang_code"
elif [[ "$CHOICE" == "SEP" ]]; then
    exit 0  # ignorar separador
else
    language_selected="$CHOICE"
fi

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
	# Alternativa para baixar o debian usando o debootstrap
	# {
	# 	for i in {1..50}; do
	# 		sleep 0.1
	# 		echo $((i * 2))
	# 	done
	# } | dialog --gauge "$label_debian_download_start" 10 60 0
	# debootstrap --arch=$archurl stable $folder http://ftp.debian.org/debian/  2>&1 | dialog --title "${label_debian_download}" --progressbox 20 70
	# sleep 2
	# {
	# 	for i in {1..50}; do
	# 		sleep 0.1
	# 		echo $((i * 2))
	# 	done
	# } | dialog --gauge "$label_debian_download_finish" 10 60 0

	show_progress_dialog wget "${label_debian_download}" 1 -O $folder.tar.xz "https://github.com/andistro/app/releases/download/debian_${codinome}/installer-${archurl}.tar.xz"
	sleep 2
	show_progress_dialog extract "${label_debian_download_extract}" "$folder.tar.xz"
	sleep 2
fi

echo "${label_start_script}"
cat > "$bin" <<- EOM
#!/bin/bash

if [ ! -d "\$HOME/storage" ];then
    termux-setup-storage
fi

#wlan_ip_localhost=\$(ifconfig 2>/dev/null | grep 'inet ' | grep broadcast | awk '{print \$2}') # IP da rede 
#sed -i "s|WLAN_IP=\"[^\"]*\"|WLAN_IP=\"\$wlan_ip_localhost\"|g" "$folder/usr/local/bin/vnc"

#cd \$(dirname \$0)
cd \$HOME

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
command+=" -b /data/data/com.termux/files/home:/termux-home"
command+=" -b /sdcard/termux/andistro/boot/debian/trixie:/root"
## uncomment the following line to mount /sdcard directly to / 
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
#command+=" LANG=C.UTF-8"
command+=" LANG=$language_transformed.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ]; then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

chmod +x $bin

error_code="LG001br"
show_progress_dialog "wget" "${label_language_download}" 1 -P "$folder/root/" "${extralink}/config/package-manager-setups/apt/locale/locale_${language_selected}.sh"
sleep 2
chmod +x $folder/root/locale_${language_selected}.sh

echo "127.0.0.1 localhost localhost" > $folder/etc/hosts

echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf > /dev/null 2>&1

echo "$system_timezone" | tee $folder/etc/timezone > /dev/null 2>&1

# Se não existir, será criado

mkdir -p "$folder/usr/share/backgrounds/"
mkdir -p "$folder/usr/share/icons/"
mkdir -p "$folder/root/.vnc/"

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
sleep 2

show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/xfce4/config.sh"
sleep 2
chmod +x $folder/root/config-environment.sh

sleep 4
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

cat > $folder/root/.bash_profile <<- EOM
#!/bin/bash
export LANG=$language_transformed.UTF-8

source "/usr/local/bin/global_var_fun.sh"

echo -e "\n\n${label_alert_autoupdate_for_u}\n\n"

echo "alias ls='ls --color=auto'" >> ~/.bashrc

#echo 'deb http://deb.debian.org/debian $codinome main contrib non-free non-free-firmware
#deb http://security.debian.org/debian-security $codinome-security main contrib non-free
#deb http://deb.debian.org/debian $codinome-updates main contrib non-free' >> /etc/apt/sources.list

#======================================================================================================
# global_var_fun.sh == update_progress() {}
update_progress() {
    local current_step=\$1
    local total_steps=\$2
    local percent=\$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=\$((percent * bar_length / 100))
    local empty_length=\$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=\$(printf "%\${filled_length}s" | tr " " "=")
    empty_bar=\$(printf "%\${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "\$filled_bar" "\$empty_bar" "\$percent" > /dev/tty
}

total_steps=4
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "\$current_step" "\$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt install sudo --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando sudo"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt install wget --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt install dialog --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
#======================================================================================================

etc_timezone=\$(cat /etc/timezone)

sudo ln -sf "/usr/share/zoneinfo/\$etc_timezone" /etc/localtime

bash ~/locale_\$system_icu_locale_code.sh

bash ~/system-config.sh

bash ~/config-environment.sh

mkdir -p "/root/Desktop"

if [ ! -e "~/start-environment.sh" ];then
	bash ~/start-environment.sh
fi

sed -i '\|export LANG|a LANG=$language_transformed.UTF-8|' ~/.vnc/xstartup

rm -rf ~/locale*.sh
rm -rf ~/.bash_profile
rm -rf ~/.hushlogin
rm -rf ~/system-config.sh
rm -rf ~/config-environment.sh
rm -rf ~/start-environment.sh
EOM


# Cria uma gui de inicialização
sed -i '\|command+=" /bin/bash --login"|a command+=" -b /usr/local/bin/startvncserver"' $bin
bash $bin
rm -rf $HOME/start-distro.sh