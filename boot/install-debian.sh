#!/data/data/com.termux/files/usr/bin/bash
# Variáveis de configuração
# "$config_file" "$andistro_files" "$distro_name" "$bin" "$folder" "$binds" "$language_selected" "$language_transformed" "$archurl"
config_file="$1"
andistro_files="$2"
distro_name="$3"
bin="$4"
folder="$5"
binds="$6"
language_selected="$7"
language_transformed="$8"
archurl="$9"
config_environment="${10}"
distro_theme="${11}"

source "$PREFIX/var/lib/andistro/lib/share/global"
# Fonte modular configuração global

#=============================================================================================
# Caso a versão já tenha sido baixada, não baixar novamente
if [ -d "$folder" ]; then
	first=1
	echo "${label_skip_download}"
fi

sleep 2
# Baixar
label_distro_download=$(printf "$label_distro_download" "$distro_name")
label_distro_download_start=$(printf "$label_distro_download_start" "$distro_name")
label_distro_download_extract=$(printf "$label_distro_download_extract" "$distro_name")
label_distro_download_finish=$(printf "$label_distro_download_finish" "$distro_name")

if [ "$first" != 1 ];then
	{
		for i in {1..50}; do
			sleep 0.1
			echo $((i * 2))
		done
	} | dialog --no-shadow --gauge "$label_distro_download_start" 10 60 0
	debootstrap --arch=$archurl --variant=minbase --include=dialog,sudo,wget,nano,locales stable $folder http://deb.${distro_name}.org/${distro_name}/  2>&1 | dialog --no-shadow --title "${label_distro_download}" --progressbox 20 70
	{
		for i in {1..50}; do
			sleep 0.1
			echo $((i * 2))
		done
	} | dialog --no-shadow --gauge "$label_distro_download_finish" 10 60 0
fi
# =============================================================================================
# Criar o script de inicialização


# cat > $bin <<- EOM
# #!/bin/bash
# if [ ! -d "\$HOME/storage" ];then
#     termux-setup-storage
# fi

# #cd \$(dirname \$0)
# cd \$HOME

# #Start termux-x11
# #termux-x11 :1 &

# pulseaudio --start --exit-idle-time=-1
# PA_PID=\$(pgrep pulseaudio)
# pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
# pacmd load-module module-aaudio-sink

# ## unset LD_PRELOAD in case termux-exec is installed
# unset LD_PRELOAD
# command="proot"
# command+=" --kill-on-exit"
# command+=" --link2symlink"
# command+=" -0"
# command+=" -r $folder"
# command+=" -b /dev"
# command+=" -b /dev/null:/proc/sys/kernel/cap_last_cap"
# command+=" -b /proc"
# command+=" -b \$TMPDIR:/tmp"
# command+=" -b /proc/meminfo:/proc/meminfo"
# command+=" -b /sys"
# command+=" -b /data"
# command+=" -b $folder/root:/dev/shm"
# command+=" -b $config_file/proc/fakethings/stat:/proc/stat"
# command+=" -b $config_file/proc/fakethings/vmstat:/proc/vmstat"
# #command+=" -b $config_file/proc/fakethings/version:/proc/version"
# ## uncomment the following line to have access to the home directory of termux
# command+=" -b /data/data/com.termux/files/home:/termux/home"
# command+=" -b $andistro_files/lib/share:/usr/local/bin/andistro"
# command+=" -b $andistro_files/boot:/usr/local/bin/andistro/boot"
# command+=" -b $andistro_files/boot/.config/debian-based/bin:/usr/local/bin/"
# command+=" -b $PREFIX/bin/andistro:/usr/local/bin/andistro/bin/andistro"
# command+=" -b /sdcard"
# command+=" -w /root"
# command+=" /usr/bin/env -i"
# command+=" MOZ_FAKE_NO_SANDBOX=1"
# command+=" HOME=/root"
# command+=" DISPLAY=:1"
# command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
# command+=" TERM=\$TERM"
# #command+=" LANG=C.UTF-8"
# command+=" LANG=$language_transformed.UTF-8"
# command+=" /bin/bash --login"
# com="\$@"
# if [ -z "\$1" ]; then
#     exec \$command
# else
#     \$command -c "\$com"
# fi
# PA_PID=\$(pgrep pulseaudio)
# if [ -n "\$PA_PID" ]; then
#   kill \$PA_PID
# fi
# EOM


# Configurações pós-instalação
# copia o arquivo de configuração de idioma da pasta $PREFIX/var/lib/andistro/boot/.configs/debian-based/locale_setup/ ppara o root
cp "$config_file/start-distro" $bin
chmod +x $bin

cp "$config_file/.bash_profile" $folder/root/.bash_profile
chmod +x $folder/root/.bash_profile

cp $config_file/locale_setup/locale_${language_selected}.sh $folder/root/locale_${language_selected}.sh
cp $config_file/system-config.sh $folder/root/system-config.sh
cp $config_file/wallpapers.sh $folder/root/wallpapers.sh
cp "$config_file/environment/$config_environment/config-environment.sh" "$folder/root/config-environment.sh"
if [ "$config_environment" = "xfce4" ]; then
    # Coloque aqui o comando que você quer executar quando for XFCE4
	cp "$config_file/environment/$config_environment/xfce4-panel.tar.bz2" "$folder/root/xfce4-panel.tar.bz2"
fi



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

sleep 4
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

# Cria o arquivo bash_profile para as configurações serem iniciadas junto com o sistema

# Inicia o sistema
bash $bin ./bash_profile "$distro_name" "$distro_theme" "$language_selected" "$language_transformed"