#!/bin/bash
# Variáveis de configuração
distro_name="$1"
distro_theme="$2"
default_locale_system="$3"
etc_timezone=$(cat /etc/timezone)

default_locale_env="${default_locale_system//-/_}"
export LANG=$default_locale_env.UTF-8

# Fonte modular configuração global
source "/usr/local/lib/andistro/global"

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"

cat << 'EOF' >> ~/.bashrc

termux-cmd() {
    local file="/termux/home/andistro-bridge"
    rm -f "$file" 2>/dev/null
    printf "%s" "$1" > "$file"
}
EOF

show_progress_dialog steps-one-label "${label_progress}" 28 \
    "sed -i \"s/^# *\($default_locale_env.UTF-8\)/\1/\" /etc/locale.gen" \
    "sudo locale-gen $default_locale_env.UTF-8" \
    "echo \"LANG=$default_locale_env.UTF-8\" > /etc/locale.conf" \
    "echo \"export LANG=$default_locale_env.UTF-8\" >> $HOME/.bashrc" \
    "echo \"export LANGUAGE=$default_locale_env.UTF-8\" >> $HOME/.bashrc" \
    "apt update" \
    "sudo install -d -m 0755 /etc/apt/keyrings" \
    "wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc" \
    "echo \"deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main\" | sudo tee -a /etc/apt/sources.list.d/mozilla.list" \
    "echo -e \"\\nPackage: *\\nPin: origin packages.mozilla.org\\nPin-Priority: 1000\" | sudo tee /etc/apt/preferences.d/mozilla" \
    "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg" \
    "sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg" \
    "echo 'deb [arch=arm64,armhf,amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list" \
    "rm -f packages.microsoft.gpg" \
    "sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg" \
    "sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources" \
    "sudo curl -fsSLo /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg" \
    "sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-beta.sources https://brave-browser-apt-beta.s3.brave.com/brave-browser.sources" \
    "sudo curl -fsSLo /usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg https://brave-browser-apt-nightly.s3.brave.com/brave-browser-nightly-archive-keyring.gpg" \
    "sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-nightly.sources https://brave-browser-apt-nightly.s3.brave.com/brave-browser.sources" \
    "apt update" \
    "sudo apt install language-pack-gnome-$default_locale_lang_global -y" \
    "sudo apt install language-pack-$default_locale_lang_global -y" \
    "sudo dpkg --configure -a" \
    "sudo apt --fix-broken install -y" \
    "sudo ln -sf \"/usr/share/zoneinfo/$etc_timezone\" /etc/localtime" \
    "dialog --create-rc $HOME/.dialogrc" \
    "sed -i \"s|use_shadow = ON|use_shadow = OFF|g\" $HOME/.dialogrc"

# Executa as configurações base do sistema
bash $HOME/system-config.sh "$distro_theme" "$distro_name"

show_progress_dialog steps-multi-label 4 \
    "${label_wallpaper_download}\n\n → AnDistro: " 'mkdir -p /usr/share/backgrounds/andistro'\
    "${label_wallpaper_download}\n\n → AnDistro: Light" 'wget -O "/usr/share/backgrounds/andistro/andistro-light.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/light.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Medium" 'wget -O "/usr/share/backgrounds/andistro/andistro-medium.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/medium.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Dark" 'wget -O "/usr/share/backgrounds/andistro/andistro-dark.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/dark.jpg"'


# Configurações da inteface escolhida
bash "$HOME/config-environment.sh" "$distro_theme"
distro_name="$(tr '[:lower:]' '[:upper:]' <<< "${distro_name:0:1}")${distro_name:1}"
label_distro_boot=$(printf "$label_distro_boot" "$distro_name")

echo "echo -e \"\033[1;96m$label_distro_boot\033[0m\"" >> $HOME/.bashrc

rm -rf $HOME/.hushlogin
rm -rf $HOME/system-config.sh
rm -rf $HOME/config-environment.sh
rm -rf $HOME/.bash_profile
rm -rf $HOME/.dialogrc

exit