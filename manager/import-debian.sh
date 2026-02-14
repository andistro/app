#!/data/data/com.termux/files/usr/bin/bash
# Variáveis de configuração
config_file="$1"
andistro_files="$2"
distro_name="$3"
bin="$4"
folder="$5"
binds="$6"
archurl="$7"
config_environment="$8"
distro_theme="$9"
distro_version="${10}"

source "$PREFIX/var/lib/andistro/lib/share/global" # Fonte modular configuração global

#=============================================================================================
# Caso a versão já tenha sido baixada, não baixar novamente
if [ -d "$folder" ]; then
	first=1
	echo "${label_skip_download}"
fi

sleep 2
# Baixar
label_distro_download=$(printf "$label_distro_download" "Debian")
label_distro_download_start=$(printf "$label_distro_download_start" "Debian")
label_distro_download_finish=$(printf "$label_distro_download_finish" "Debian")

if [ "$first" != 1 ];then

mkdir -p "/data/data/com.termux/files/usr/var/lib/andistro/manager/debian/stable"


show_progress_dialog steps-one-label "Copiando o Debian do Proot-Distro para o Andistro" 7 \
    'sleep 1' \
    'sleep 1' \
    'sleep 1' \
    'mkdir -p "/data/data/com.termux/files/usr/var/lib/andistro/manager/debian/stable"'\
    'sleep 1' \
    'cp -a "/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian"/* "/data/data/com.termux/files/usr/var/lib/andistro/manager/debian/stable/"' \
    'sleep 5'


fi

# Configurações pós-instalação
# copia o arquivo de configuração de idioma da pasta $PREFIX/var/lib/andistro/manager/.configs/debian-based/locale_setup/ ppara o root
cp "$config_file/start-distro" $bin

sed -i "s|command+=\" LANG=\$system_icu_lang_code_env.UTF-8\"|command+=\" LANG=$system_icu_lang_code_env.UTF-8\"|g" $bin

chmod +x $bin

rm -rf $folder/root/.bash_profile
cp "$config_file/.bash_profile" $folder/root/.bash_profile

sed -i "s|distro_name=\"\"|distro_name=\"$distro_name\"|g" $folder/root/.bash_profile
sed -i "s|distro_theme=\"\"|distro_theme=\"$distro_theme\"|g" $folder/root/.bash_profile
sed -i "s|LANG=\"\"|LANG=\"$system_icu_lang_code_env.UTF-8\"|g" $folder/root/.bash_profile
	
cp $config_file/system-config.sh $folder/root/system-config.sh

if [ "$config_environment" = "null" ]; then
	echo " "
elif [ "$config_environment" = "xfce4" ]; then
    # Coloque aqui o comando que você quer executar quando for XFCE4
	cp "$config_file/environment/$config_environment/config-environment.sh" "$folder/root/config-environment.sh"
	cp "$config_file/environment/$config_environment/xfce4-panel.tar.bz2" "$folder/root/xfce4-panel.tar.bz2"
elif [ "$config_environment" = "lxde" ]; then
    # Coloque aqui o comando que você quer executar quando for LXDE
	cp "$config_file/environment/$config_environment/config-environment.sh" "$folder/root/config-environment.sh"
fi


# Adicionar entradas em hosts, resolv.conf e timezone
echo "127.0.0.1 localhost localhost" | tee $folder/etc/hosts > /dev/null 2>&1
echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf > /dev/null 2>&1
echo "$system_timezone" | tee $folder/etc/timezone > /dev/null 2>&1

# KERNEL_VERSON=$(uname -r)

# if [ ! -f "${folder}/proc/fakethings/version" ]; then
# 	cat <<- EOF > "${folder}/proc/fakethings/version"
# 	$KERNEL_VERSION (FakeAndroid)
# 	EOF
# fi

echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

# Cria o arquivo bash_profile para as configurações serem iniciadas junto com o sistema

# Inicia o sistema
bash $bin