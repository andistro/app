#!/data/data/com.termux/files/usr/bin/bash
# Variáveis de configuração
# "$config_file" "$andistro_files" "$distro_name" "$bin" "$folder" "$binds" "$default_locale_system" "$default_locale_env" "$archurl"
config_file="$1"
andistro_files="$2"
distro_name="$3"
bin="$4"
folder="$5"
binds="$6"
default_locale_system="$7"
default_locale_env="$8"
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
label_distro_download_finish=$(printf "$label_distro_download_finish" "$distro_name")

if [ "$first" != 1 ];then
	echo "$label_distro_download_start"
	sleep 2
	debootstrap --arch=$archurl --variant=minbase --include=dialog,sudo,wget,nano,locales stable $folder http://deb.${distro_name}.org/${distro_name}/
	echo "$label_distro_download_finish"
	sleep 2
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
# command+=" -b $andistro_files/lib/share:/usr/local/lib/andistro"
# command+=" -b $andistro_files/boot:/usr/local/lib/andistro/boot"
# command+=" -b $andistro_files/boot/.config/debian-based/bin:/usr/local/bin/"
# command+=" -b $PREFIX/bin/andistro:/usr/local/lib/andistro/bin/andistro"
# command+=" -b /sdcard"
# command+=" -w /root"
# command+=" /usr/bin/env -i"
# command+=" MOZ_FAKE_NO_SANDBOX=1"
# command+=" HOME=/root"
# command+=" DISPLAY=:1"
# command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
# command+=" TERM=\$TERM"
# #command+=" LANG=C.UTF-8"
# command+=" LANG=$default_locale_env.UTF-8"
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

cp $config_file/locale_setup/locale_${default_locale_system}.sh $folder/root/locale_${default_locale_system}.sh
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
cat > $folder/root/.bash_profile <<- EOM
#!/bin/bash
export LANG=$default_locale_env.UTF-8
export distro_id="$distro_name"
export distro_theme="$distro_theme"
# Fonte modular configuração global
source "/usr/local/lib/andistro/global"

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"

sed -i 's/^# *\($default_locale_env.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo 'LANG=$default_locale_env.UTF-8' > /etc/locale.conf
echo 'export LANG=$default_locale_env.UTF-8' >> ~/.bashrc
echo 'export LANGUAGE=$default_locale_env.UTF-8' >> ~/.bashrc
apt update

sudo dpkg --configure -a
sudo apt --fix-broken install -y
etc_timezone=\$(cat /etc/timezone)
sudo ln -sf "/usr/share/zoneinfo/\$etc_timezone" /etc/localtime

sudo apt install --no-install-recommends -y xz-utils keyboard-configuration curl gpg git python3 tar unzip zip apt-utils lsb-release exo-utils tigervnc-standalone-server tigervnc-common tigervnc-tools dbus-x11 nano inetutils-tools net-tools font-manager synaptic gvfs-backends bleachbit make tumbler
sudo apt install --no-install-recommends -y pulseaudio pavucontrol

echo "Firefox Repository"
sleep 2
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list
echo -e "Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla

echo "VS Code Repository"
sleep 2
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list
rm -f packages.microsoft.gpg

apt update
sleep 2

sudo apt install --no-install-recommends -y firefox code

mkdir -p "/usr/share/icons/"'
mkdir -p "\$HOME/.config/gtk-3.0"

echo -e "file:///sdcard sdcard" | sudo tee \$HOME/.config/gtk-3.0/bookmarks


echo "Themes"
sleep 2

git clone https://github.com/andistro/themes.git
mv themes/AnDistro*/ /usr/share/themes/

git clone https://github.com/ZorinOS/zorin-icon-themes.git
mv zorin-icon-themes/Zorin*/ /usr/share/icons/


sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop

xdg-user-dirs-update

echo -e '[Settings]\ngtk-theme-name=AnDistro-Majorelle-Blue-${distro_theme}' | sudo tee \$HOME/.config/gtk-3.0/settings.ini
echo 'gtk-theme-name=\"AnDistro-Majorelle-Blue-${distro_theme}\"' | sudo tee \$HOME/.gtkrc-2.0

sudo dpkg --configure -a
sudo apt --fix-broken install -y

echo "alias ls='ls --color=auto'" >> ~/.bashrc

echo "source \"/usr/local/lib/andistro/global\" >> ~/.bashrc

sudo apt clean


EOM
bash $bin