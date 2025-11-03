#!/bin/bash
# Variáveis de configuração
distro_name="$1"
distro_theme="$2"
default_locale_system="$3"
default_locale_env="${default_locale_system//-/_}"
export LANG=$default_locale_env.UTF-8
default_locale_env_lower=$(echo "$LANG" | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')
# Fonte modular configuração global
source "/usr/local/lib/andistro/global"

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"

#======================================================================================================
# global == update_progress() {}

sed -i "s/^# *\($default_locale_env.UTF-8\)/\1/" /etc/locale.gen

sudo locale-gen $default_locale_env.UTF-8

echo -e "LANG=$default_locale_env.UTF-8 \nLANGUAGE=$default_locale_env.UTF-8" > /etc/locale.conf

echo "export LANG=$default_locale_env.UTF-8" >> ~/.bashrc 

echo "export LANGUAGE=$default_locale_env.UTF-8" >> ~/.bashrc

echo "export LANGUAGE=$default_locale_env.UTF-8" >> ~/.bashrc

apt update

sudo install -d -m 0755 /etc/apt/keyrings

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list

echo -e "Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla 

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg 

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg 

echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list 

rm -f packages.microsoft.gpg 

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg 

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list 

apt update 

#echo 'export VISUAL=nano' >> ~/.bashrc
#echo 'export EDITOR=nano' >> ~/.bashrc
#======================================================================================================
sudo dpkg --configure -a 
sudo apt --fix-broken install -y 

etc_timezone=$(cat /etc/timezone)

sudo ln -sf "/usr/share/zoneinfo/$etc_timezone" /etc/localtime


dialog --create-rc $HOME/.dialogrc
sed -i "s|use_shadow = ON|use_shadow = OFF|g" $HOME/.dialogrc

sudo apt update

sudo apt upgrade


# Baixa os wallpapers adicionais
bash ~/wallpapers.sh

# Configurações da inteface escolhida
bash ~/config-environment.sh "$distro_theme"

rm -rf ~/locale*.sh
rm -rf ~/.hushlogin
rm -rf ~/system-config.sh
rm -rf ~/config-environment.sh
rm -rf ~/start-environment.sh
rm -rf ~/wallpapers.sh
rm -rf ~/.bash_profile
rm -rf ~/.dialogrc
exit