#!/data/data/com.termux/files/usr/bin/bash
# chmod +x "$PREFIX/var/lib/andistro/manager/install-test-debian.sh" && bash "$PREFIX/var/lib/andistro/manager/install-test-debian.sh"
# bash $PREFIX/var/lib/andistro/manager/install-test-debian.sh
#>>>#=============================================================================================
#>>>#PARA TESTES
source "$PREFIX/var/lib/andistro/lib/share/global"
andistro_files="$PREFIX/var/lib/andistro"
distro_name="debian"
distro_version="stable"
distro_based="debian"
distro_file="install-$distro_name.sh"

config_file="$andistro_files/manager/.config/$distro_based-based"
bin="$andistro_files/manager/start-$distro_name"
folder="$andistro_files/manager/$distro_name/$distro_version"

mkdir -p "$PREFIX/var/lib/andistro/manager/$distro_name"

# Cria diretórios necessários no armazenamento
if [ ! -d "/sdcard/termux/andistro/manager/$distro_name/$distro_version" ];then
	mkdir -p "/sdcard/termux/andistro/manager/$distro_name/$distro_version"
fi
archurl="arm64"
debootstrap --arch=$archurl --variant=minbase --include=dialog,sudo,wget,nano,locales,gpg,curl,ca-certificates $distro_version $folder http://deb.${distro_name}.org/${distro_name}/

rm -rf $folder/etc/apt/sources.list

echo "deb http://deb.debian.org/debian $distro_version main contrib non-free non-free-firmware
deb http://deb.debian.org/debian $distro_version-updates main contrib non-free
deb http://security.debian.org/debian-security $distro_version-security main contrib non-free" >> $folder/etc/apt/sources.list

chmod 644 $folder/etc/apt/sources.list
chown root:root $folder/etc/apt/sources.list

cp "$config_file/start-distro" $bin

sed -i "s|auto_cmd="andistro"|auto_cmd=""|g" $bin

sed -i "s|command+=\" LANG=\$system_icu_lang_code_env.UTF-8\"|command+=\" LANG=$system_icu_lang_code_env.UTF-8\"|g" $bin

chmod +x $bin
echo "127.0.0.1 localhost localhost" | tee $folder/etc/hosts > /dev/null 2>&1
echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf > /dev/null 2>&1
echo "$system_timezone" | tee $folder/etc/timezone > /dev/null 2>&1

echo 'VARIANT="AnDistro"
VARIANT_ID="andistro"' >> $folder/etc/os-release


sed -i "s/^# *\($system_icu_lang_code_env.UTF-8\)/\1/" $folder/etc/locale.gen

echo -e "LANG=$system_icu_lang_code_env.UTF-8" > $folder/etc/locale.conf

echo "export LANG=$system_icu_lang_code_env.UTF-8" >> $folder/root/.bashrc 

echo "export LANGUAGE=$system_icu_lang_code_env.UTF-8" >> $folder/root/.bashrc

echo "export LANGUAGE=$system_icu_lang_code_env.UTF-8" >> $folder/root/.bashrc

bash $bin "locale-gen $system_icu_lang_code_env.UTF-8"

bash $bin
#>>>#=============================================================================================