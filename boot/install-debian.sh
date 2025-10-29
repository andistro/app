#!/data/data/com.termux/files/usr/bin/bash
# Variáveis de configuração
# "$config_file" "$andistro_files" "$distro_name" "$bin" "$folder" "$binds" "$language_selected" "$language_transformed" "$archurl"
export config_file="$1"
export andistro_files="$2"
export distro_name="$3"
export bin="$4"
export folder="$5"
export binds="$6"
export language_selected="$7"
export language_transformed="$8"
export archurl="$9"

# Fonte modular configuração global
source "$PREFIX/var/lib/andistro/lib/share/global"

#=============================================================================================
# Caso a versão já tenha sido baixada, não baixar novamente
if [ -d "$folder" ]; then
	first=1
	echo "${label_skip_download}"
fi

sleep 2
# Baixar
if [ "$first" != 1 ];then
	{
		for i in {1..50}; do
			sleep 0.1
			echo $((i * 2))
		done
	} | dialog --gauge "$label_distro_download_start" 10 60 0
	debootstrap --arch=$archurl stable $folder http://ftp.${distro_name}.org/${distro_name}/  2>&1 | dialog --title "${label_distro_download}" --progressbox 20 70
fi
# =============================================================================================
# Criar o script de inicialização
cat > $bin <<- EOM
#!/bin/bash
if [ ! -d "\$HOME/storage" ];then
    termux-setup-storage
fi

#cd \$(dirname \$0)
cd \$HOME

#Start termux-x11
#termux-x11 :1 &

pulseaudio --start --exit-idle-time=-1
PA_PID=\$(pgrep pulseaudio)
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
pacmd load-module module-aaudio-sink

## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A $binds)" ]; then
    for f in $binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /dev/null:/proc/sys/kernel/cap_last_cap"
command+=" -b /proc"
command+=" -b \$TMPDIR:/tmp"
command+=" -b /proc/meminfo:/proc/meminfo"
command+=" -b /sys"
command+=" -b /data"
command+=" -b $folder/root:/dev/shm"
command+=" -b $config_file/proc/fakethings/stat:/proc/stat"
command+=" -b $config_file/proc/fakethings/vmstat:/proc/vmstat"
#command+=" -b $config_file/proc/fakethings/version:/proc/version"
## uncomment the following line to have access to the home directory of termux
command+=" -b /data/data/com.termux/files/home:/termux/home"
command+=" -b $andistro_files/lib/share:/usr/local/bin/andistro"
command+=" -b $andistro_files/boot:/usr/local/bin/andistro/boot"
command+=" -b $andistro_files/boot/.config/debian-based/bin:/usr/local/bin/"
command+=" -b $PREFIX/bin/andistro:/usr/local/bin/andistro/bin/andistro"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" MOZ_FAKE_NO_SANDBOX=1"
command+=" HOME=/root"
command+=" DISPLAY=:1"
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
PA_PID=\$(pgrep pulseaudio)
if [ -n "\$PA_PID" ]; then
  kill \$PA_PID
fi
EOM
chmod +x $bin

# Configurações pós-instalação
# copia o arquivo de configuração de idioma da pasta $PREFIX/var/lib/andistro/boot/.configs/debian-based/locale_setup/ ppara o root
cp $config_file/locale_setup/locale_${language_selected}.sh $folder/root/locale_${language_selected}.sh
cp $config_file/system-config.sh $folder/root/system-config.sh
cp $config_file/wallpapers.sh $folder/root/wallpapers.sh

# Adicionar entradas em hosts, resolv.conf e timezone
echo "127.0.0.1 localhost localhost" | tee $folder/etc/hosts
echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf 
echo "$system_timezone" | tee $folder/etc/timezone

# Se não existir, será criado
mkdir -p "$folder/usr/share/backgrounds/"
mkdir -p "$folder/usr/share/icons/"
mkdir -p "$folder/root/.vnc/"

# KERNEL_VERSON=$(uname -r)

# if [ ! -f "${folder}/proc/fakethings/version" ]; then
# 	cat <<- EOF > "${folder}/proc/fakethings/version"
# 	$KERNEL_VERSION (FakeAndroid)
# 	EOF
# fi

# Escolher o ambiente gráfico
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

OPTIONS=(1 "${MENU_environments_select_default} (XFCE4)"
		 2 "${MENU_environments_select_light} (LXDE)"
		 3 "${MENU_environments_select_null}") 

CHOICE=$(dialog --no-shadow --clear \
                --title "$TITLE" \
                --menu "$MENU_environments_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
	1)	
		# XFCE
		cp "$config_file/environment/xfce4/config-environment.sh" "$folder/root/config-environment.sh"
		cp "$config_file/environment/xfce4/xfce4-panel.tar.bz2" "$folder/root/xfce4-panel.tar.bz2"
		sleep 2
		;;
	2)	
		# LXDE
		cp "$config_file/environment/lxde/config-environment.sh" "$folder/root/config-environment.sh"
		sleep 2
	;;
	3)
		# Nenhum escolhido
		rm -rf "$folder/root/system-config.sh"
		sleep 2
	;;
esac
clear

sleep 4
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

# Cria o arquivo bash_profile para as configurações serem iniciadas junto com o sistema
cat > $folder/root/.bash_profile <<- EOM
#!/bin/bash
export LANG=$language_transformed.UTF-8

# Fonte modular configuração global
source "/usr/local/bin/andistro/global"

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"

#======================================================================================================
# global == update_progress() {}
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

total_steps=5
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

if ! dpkg -l | grep -qw nano; then
    apt install nano --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando nano"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
#======================================================================================================
sudo dpkg --configure -a > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1

etc_timezone=\$(cat /etc/timezone)

sudo ln -sf "/usr/share/zoneinfo/\$etc_timezone" /etc/localtime

# Executa as configurações de idioma
bash ~/locale_$language_selected.sh

# Baixa os wallpapers adicionais
bash ~/wallpapers.sh

# Seletor de tema
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

OPTIONS=(1 "\${MENU_theme_select_light}"
		 2 "\${MENU_theme_select_dark}")

CHOICE=\$(dialog --no-shadow --clear \
                --title "\$TITLE" \
                --menu "\$MENU_theme_select" \
                \$HEIGHT \$WIDTH \$CHOICE_HEIGHT \
                "\${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case \$CHOICE in
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
export distro_id="$distro_name"
bash ~/system-config.sh "\$distro_theme" "\$distro_id"

# Configurações da inteface escolhida
bash ~/config-environment.sh "\$distro_theme"

rm -rf ~/locale*.sh
rm -rf ~/.hushlogin
rm -rf ~/system-config.sh
rm -rf ~/config-environment.sh
rm -rf ~/start-environment.sh
rm -rf ~/wallpapers.sh
rm -rf ~/app-list-recommends.sh
rm -rf ~/.bash_profile
exit
EOM

# Inicia o sistema
bash $bin