#!/bin/bash
# Variáveis de configuração
distro_name="$1"
distro_theme="$2"
default_locale_system="$3"
default_locale_env="${default_locale_system//-/_}"
export LANG=$default_locale_env.UTF-8
# Fonte modular configuração global
source "/usr/local/lib/andistro/global"

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"

#======================================================================================================
# global == update_progress() {}
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

total_steps=19
current_step=0

sed -i "s/^# *\($default_locale_env.UTF-8\)/\1/" /etc/locale.gen > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" ""
sleep 0.5

sudo locale-gen $default_locale_env.UTF-8 > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo "LANG=$default_locale_env.UTF-8" > /etc/locale.conf > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo "export LANG=$default_locale_env.UTF-8" >> $HOME/.bashrc > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo "export LANGUAGE=$default_locale_env.UTF-8" >> $HOME/.bashrc > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

apt update > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

sudo install -d -m 0755 /etc/apt/keyrings > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

rm -f packages.microsoft.gpg > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

apt update > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

sudo apt install language-pack-gnome-$default_locale_lang_global -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

sudo apt install language-pack-$default_locale_lang_global -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps"; sleep 0.5

#echo 'export VISUAL=nano' >> $HOME/.bashrc
#echo 'export EDITOR=nano' >> $HOME/.bashrc
#======================================================================================================
sudo dpkg --configure -a > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1

etc_timezone=$(cat /etc/timezone)

sudo ln -sf "/usr/share/zoneinfo/$etc_timezone" /etc/localtime

# Executa as configurações de idioma
#bash $HOME/locale_$default_locale_system.sh

# Executa as configurações base do sistema

dialog --create-rc $HOME/.dialogrc
sed -i "s|use_shadow = ON|use_shadow = OFF|g" $HOME/.dialogrc

bash $HOME/system-config.sh "$distro_theme" "$distro_name"

# Baixa os wallpapers adicionais
show_progress_dialog steps-multi-label 4 \
    "${label_wallpaper_download}\n\n → AnDistro: " 'mkdir -p /usr/share/backgrounds/andistro'\
    "${label_wallpaper_download}\n\n → AnDistro: Light" 'wget -O "/usr/share/backgrounds/andistro/andistro-light.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/light.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Medium" 'wget -O "/usr/share/backgrounds/andistro/andistro-medium.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/medium.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Dark" 'wget -O "/usr/share/backgrounds/andistro/andistro-dark.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/dark.jpg"'

# Configurações da inteface escolhida
bash $HOME/config-environment.sh "$distro_theme"

distro_name="$(tr '[:lower:]' '[:upper:]' <<< "${distro_name:0:1}")${distro_name:1}"
label_distro_boot=$(printf "$label_distro_boot" "$distro_name")

echo "echo -e \"\033[1;96m$label_distro_boot\033[0m\"" >> $HOME/.bashrc

rm -rf $HOME/locale*.sh
rm -rf $HOME/.hushlogin
rm -rf $HOME/system-config.sh
rm -rf $HOME/config-environment.sh
rm -rf $HOME/start-environment.sh
rm -rf $HOME/wallpapers.sh
rm -rf $HOME/.bash_profile
rm -rf $HOME/.dialogrc
exit