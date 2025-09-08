#!/data/data/com.termux/files/usr/bin/bash
if [ ! -d "$HOME/storage" ];then
    termux-setup-storage
fi

if ! grep -Fq "extra-keys = [['DRAWER','SCROLL','PASTE'],['ESC','/','-','HOME','UP','END','PGUP','KEYBOARD'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN','ENTER']]" ~/.termux/termux.properties; then
    # Aplica os sed
    sed -i "s|^# *extra-keys = \[\['ESC','/','-','HOME','UP','END','PGUP'\], \\\\|extra-keys = [['DRAWER','SCROLL','PASTE'],['ESC','/','-','HOME','UP','END','PGUP','KEYBOARD'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN','ENTER']]|" ~/.termux/termux.properties
    sed -i "s|^#[[:space:]]*\['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]||" ~/.termux/termux.properties

    # Recarrega Termux settings
    termux-reload-settings
fi


apt update
apt install --option=Dpkg::Options::="--force-confold" bash -y
apt install --option=Dpkg::Options::="--force-confold" openssl -y
apt upgrade -y
apt install curl wget dialog tar unzip xz-utils dbus debootstrap proot termux-exec -y


distro_name="debian"
bin="start-$distro_name.sh"
codinome="trixie"
folder="$HOME/$distro_name/$codinome"
language_selected="pt-BR"
language_transformed="${language_selected//-/_}" # Converter de pt-BR para pt_BR
export language_selected
export language_transformed
archurl="arm64"

debootstrap --arch=$archurl $codinome $folder http://ftp.debian.org/debian

cat > $bin <<- EOM
#!/bin/bash
wlan_ip_localhost=\$(ifconfig 2>/dev/null | grep 'inet ' | grep broadcast | awk '{print \$2}') # IP da rede 
sed -i "s|WLAN_IP=\"localhost\"|WLAN_IP=\"\$wlan_ip_localhost\"|g" "$folder/usr/local/bin/vnc"

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

echo "127.0.0.1 localhost localhost" > $folder/etc/hosts

echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf

system_timezone=$(getprop persist.sys.timezone 2>/dev/null) #Só funciona no Android

echo "$system_timezone" | tee $folder/etc/timezone

mkdir -p "$folder/usr/share/backgrounds/"

mkdir -p "$folder/usr/share/icons/"

mkdir -p "$folder/root/.vnc/"

mkdir -p "$folder/root/.config/gtk-3.0"
echo -e "file:/// raiz\nfile:///sdcard sdcard" | sudo tee "$folder/root/.config/gtk-3.0/bookmarks"


cat > "$folder/usr/local/bin/vnc" <<- EOM
#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
WLAN_IP="localhost"

LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1 vncserver -localhost no -depth 24 -name remote-desktop $GEO :$PORT
clear
echo -e "O servidor VNC foi iniciado. Utilize a senha da conta \$USER\n
Local: \$HOSTNAME:\$PORT / 120.0.0.1:\$PORT / \$WLAN_IP:\$PORT\n\n
Esqueceu a senha? Use o comando 'vncpasswd' para redefinir a senha do VNC.\n"
EOM
chmod +x "$folder/usr/local/bin/vnc"

# Comando para criar a senha
cat > "$folder/usr/local/bin/vncpasswd" <<- EOM
#!/bin/bash
if ! dpkg -l | grep -qw dialog; then
    apt install dialog -y > /dev/null 2>&1
fi
source "/usr/local/bin/global_var_fun.sh"

while true; do
    dialog --msgbox "Toque no botão para abrir o teclado (⌨) caso esteja usando um teclado virtual para que não exista erro ao criar a senha. \nCaso esteja usando um teclado físico, pressione a tecla Enter." 0 0
    msgbox_status=$?

    if [ "\$msgbox_status" -eq 0 ]; then
        PASSWORD=\$(dialog --insecure --passwordbox "Digite a senha: " 0 0 3>&1 1>&2 2>&3)
        if [ \$? -eq 0 ]; then
            break
        else
            echo "Entrada cancelada pelo usuário."
            exit 1
        fi
    else
        clear
        echo "Tentando novamente (status=\$msgbox_status)"
        sleep 0.5
    fi
done

# Salvar a senha no arquivo apropriado
if ! /usr/bin/vncpasswd -f <<<"\$PASSWORD"$'\n'"\$PASSWORD" > "\$HOME/.vnc/passwd"; then
    dialog --title "Erro" --msgbox "Falha ao salvar a senha!" 0 0
    exit 1
fi

# Proteger o arquivo com permissão segura
chmod 600 "\$HOME/.vnc/passwd"

# Barra de progresso
{
    for ((i = 0; i <= 100; i+=2)); do
        sleep 0.08
        echo \$i
    done
} | dialog --gauge "A senha do VNC foi alterada com sucesso." 6 50 0

clear
EOM
chmod +x "$folder/usr/local/bin/vncpasswd"

if [ ! -d "/data/data/com.termux/files/usr/var/run/dbus" ];then
    mkdir -p /data/data/com.termux/files/usr/var/run/dbus # criar a pasta que o dbus funcionará
    echo "pasta criada"
fi

rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid #remover o pid para que o dbus-daemon funcione corretamente
rm -rf /data/data/com.termux/files/usr/var/run/dbus/system_bus_socket
rm -rf $HOME/system_bus_socket

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

rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid
dbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket
sed -i "\|command+=\" -b $folder/root:/dev/shm\"|a command+=\" -b system_bus_socket:/run/dbus/system_bus_socket\"" $bin
sed -i '1 a\rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid \ndbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket\n' $bin

echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

cat > $folder/root/.bash_profile <<- EOM
#!/bin/bash
export LANG=$language_transformed.UTF-8

echo "Atualizações e instalações necessárias"

apt update
apt autoremove --purge whiptail -y
apt --fix-broken install -y
apt install dbus dbus-bin sudo wget dialog locales gpg curl -y
sed -i 's/^# *\(pt_BR.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo 'export LC_ALL=pt_BR.UTF-8' >> ~/.bashrc
echo 'export LANG=pt_BR.UTF-8' >> ~/.bashrc
echo 'export LANGUAGE=pt_BR.UTF-8' >> ~/.bashrc
apt update

sudo apt autoremove --purge snapd flatpak -y
sudo apt purge snapd flatpak -y
sudo rm -rf ~/snap
sudo rm -rf /var/cache/snapd
sudo rm -rf /var/cache/flatpak
sudo apt clean

sudo apt full-upgrade -y

sudo apt install keyboard-configuration -y

sudo DEBIAN_FRONTEND=noninteractive apt install tzdata -y
etc_timezone=\$(cat /etc/timezone)
sudo ln -sf "/usr/share/zoneinfo/\$etc_timezone" /etc/localtime

# Firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list
echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla

#Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list
rm -f packages.microsoft.gpg

sudo apt update
sudo apt install xz-utils curl gpg git python3 python3-gi python3-psutil tar unzip apt-utils nano inetutils-tools evince at-spi2-core bleachbit firefox firefox-l10n-$language_transformed code brave-browser -y
sudo apt install dconf-cli lsb-release exo-utils tigervnc-standalone-server tigervnc-common tigervnc-tools xterm xorg dbus-x11 nautilus font-manager synaptic gvfs-backends --no-install-recommends -y
sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop

sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|' /usr/share/applications/code*.desktop # Isso faz o VSCode iniciar
sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/brave-browser.desktop # Isso faz o Brave iniciar
sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/com.brave.Browser.desktop # Isso faz o Brave iniciar


git clone https://github.com/ZorinOS/zorin-icon-themes.git
git clone https://github.com/ZorinOS/zorin-desktop-themes.git

cd zorin-icon-themes
mv Zorin*/ /usr/share/icons/ 
cd \$HOME
cd zorin-desktop-themes
mv Zorin*/ /usr/share/themes/
cd \$HOME

echo -e '[Settings]\\ngtk-theme-name=ZorinBlue-Dark' | sudo tee \$HOME/.config/gtk-3.0/settings.ini
echo 'gtk-theme-name=\"ZorinBlue-Dark\"' | sudo tee \$HOME/.gtkrc-2.0

sudo apt install gdm3 policykit-1 gnome-session gnome-shell gnome-terminal gnome-tweaks gnome-control-center gnome-shell-extensions gnome-shell-extension-dashtodock gnome-package-updater gnome-calculator --no-install-recommends -y
cat > \$HOME/.vnc/xstartup <<EOF
#!/bin/bash
export LANG
export PULSE_SERVER=127.0.0.1
gnome-shell --x11
EOF
chmod +x ~/.vnc/xstartup
echo 'export DISPLAY=":1"' >> /etc/profile

touch ~/.Xauthority
vncserver -name remote-desktop -geometry 1920x1080 :1
sleep 10
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/john-towner-JgOeRuGD_Y4.jpg'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/john-towner-JgOeRuGD_Y4.jpg'" \
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
dbus-launch xfconf-query -c xsettings -p /Net/ThemeName -s ZorinBlue-Dark
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.desktop.interface icon-theme "ZorinBlue-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "ZorinBlue-Dark"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop']"
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
sudo apt remove --purge lilyterm -y
mv /root/.config/lilyterm/default.conf /root/.config/lilyterm/default.conf.bak
sudo apt autoremove --purge zutty -y
firefox > /dev/null 2>&1 & PID=$!; sleep 5; kill $PID
sed -i '/security.sandbox.content.level/d' ~/.mozilla/firefox/*.default-release/prefs.js
echo "user_pref(\"security.sandbox.content.level\", 0);" >> ~/.mozilla/firefox/*.default-release/prefs.js
sudo apt clean
sudo apt autoclean
sudo apt autoremove -y
sudo apt purge -y
vncserver -kill :1


rm -rf /tmp/.X*-lock
rm -rf /tmp/.X11-unix/X*
rm -rf ~/start-environment.sh
rm -rf zorin-*-themes/
rm -rf ~/.bash_profile
rm -rf ~/.hushlogin
EOM

bash $bin