#!/data/data/com.termux/files/usr/bin/bash
# chmod +x "$PREFIX/var/lib/andistro/manager/import-test-debian-proot.sh" && bash "$PREFIX/var/lib/andistro/manager/import-test-debian-proot.sh"
#>>>#=============================================================================================
#>>>#PARA TESTES

source "$PREFIX/var/lib/andistro/lib/share/global"
andistro_files="$PREFIX/var/lib/andistro"
distro_name="debian"
distro_version="stable"
distro_based="debian"

config_file="$andistro_files/manager/.config/$distro_based-based"
bin="$andistro_files/manager/start-$distro_name"
folder="$andistro_files/manager/$distro_name/$distro_version"

echo "Criando pasta para o Debian"
sleep 2
mkdir -p "$PREFIX/var/lib/andistro/manager/$distro_name"
config_environment="null"

echo "Criando pasta para o Debian $distro_version"
sleep 2
mkdir -p "$folder"

echo "Copiando o Debian do Proot-Distro"
sleep 2
cp -a "/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian"/* "/data/data/com.termux/files/usr/var/lib/andistro/manager/debian/stable/"
echo 'VARIANT="Termux Proot-Distro"
VARIANT_ID="termux-proot-distro"' >> $folder/etc/os-release

rm -rf $folder/etc/apt/sources.list

echo "deb http://deb.debian.org/debian $distro_version main contrib non-free non-free-firmware
deb http://deb.debian.org/debian $distro_version-updates main contrib non-free
deb http://security.debian.org/debian-security $distro_version-security main contrib non-free" >> $folder/etc/apt/sources.list

chmod 644 $folder/etc/apt/sources.list
chown root:root $folder/etc/apt/sources.list

cp "$config_file/start-distro" $bin

sed -i "s|command+=\" LANG=\$system_icu_lang_code_env.UTF-8\"|command+=\" LANG=$system_icu_lang_code_env.UTF-8\"|g" $bin

chmod +x $bin

echo "Instalando pacotes necessários para o Andistro"
sleep 2
bash $bin "apt update"

bash $bin "apt install dialog sudo wget nano locales gpg curl ca-certificates -y"

echo "Troca do idioma do Debian"
# Verifica se existe LANG em /etc/environment e substitui por pt_BR.UTF-8
if grep -q "^LANG=" $folder/etc/environment 2>/dev/null; then
    sed -i "s/^LANG=.*$/LANG=$system_icu_lang_code_env.UTF-8/" $folder/etc/environment
else
    echo "LANG=$system_icu_lang_code_env.UTF-8" | tee -a $folder/etc/environment > /dev/null 2>&1 
fi

echo -e "LANG=$system_icu_lang_code_env.UTF-8" > $folder/etc/locale.conf

echo "export LANG=$system_icu_lang_code_env.UTF-8" >> $folder/root/.bashrc 

echo "export LANGUAGE=$system_icu_lang_code_env.UTF-8" >> $folder/root/.bashrc

#bash $bin "apt install language-pack-$default_locale_lang_global -y"

sed -i "s/^# *\($system_icu_lang_code_env.UTF-8\)/\1/" $folder/etc/locale.gen

bash $bin "locale-gen $system_icu_lang_code_env.UTF-8"


echo "Alterando o profile do Debian"

rm -rf $folder/etc/profile
cat << 'EOF' >> $folder/etc/profile
# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "$(id -u)" -eq 0 ]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
fi
export PATH

if [ "${PS1-}" ]; then
  if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "$(id -u)" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

if [ -d /etc/profile.d ]; then
  for i in $(run-parts --list --regex '^[a-zA-Z0-9_][a-zA-Z0-9._-]*\.sh$' /etc/profile.d); do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
EOF

echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

bash $bin

# Proot-distro
# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/environment
# ANDROID_ART_ROOT=/apex/com.android.art
# ANDROID_DATA=/data
# ANDROID_I18N_ROOT=/apex/com.android.i18n
# ANDROID_ROOT=/system
# ANDROID_TZDATA_ROOT=/apex/com.android.tzdata
# BOOTCLASSPATH=/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/framework-graphics.jar:/system/framework/framework-location.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/knoxsdk.jar:/system/framework/com.samsung.android.uwb_extras.jar:/system/framework/framework-platformcrashrecovery.jar:/system/framework/framework-ondeviceintelligence-platform.jar:/system/framework/framework-nfc.jar:/system/framework/tcmiface.jar:/system/framework/telephony-ext.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/esecomm.jar:/apex/com.android.i18n/javalib/core-icu4j.jar:/apex/com.android.adservices/javalib/framework-adservices.jar:/apex/com.android.adservices/javalib/framework-sdksandbox.jar:/apex/com.android.appsearch/javalib/framework-appsearch.jar:/apex/com.android.bt/javalib/framework-bluetooth.jar:/apex/com.android.configinfrastructure/javalib/framework-configinfrastructure.jar:/apex/com.android.conscrypt/javalib/conscrypt.jar:/apex/com.android.devicelock/javalib/framework-devicelock.jar:/apex/com.android.healthfitness/javalib/framework-healthfitness.jar:/apex/com.android.ipsec/javalib/android.net.ipsec.ike.jar:/apex/com.android.media/javalib/updatable-media.jar:/apex/com.android.mediaprovider/javalib/framework-mediaprovider.jar:/apex/com.android.mediaprovider/javalib/framework-pdf.jar:/apex/com.android.mediaprovider/javalib/framework-pdf-v.jar:/apex/com.android.mediaprovider/javalib/framework-photopicker.jar:/apex/com.android.ondevicepersonalization/javalib/framework-ondevicepersonalization.jar:/apex/com.android.os.statsd/javalib/framework-statsd.jar:/apex/com.android.permission/javalib/framework-permission.jar:/apex/com.android.permission/javalib/framework-permission-s.jar:/apex/com.android.profiling/javalib/framework-profiling.jar:/apex/com.android.scheduling/javalib/framework-scheduling.jar:/apex/com.android.sdkext/javalib/framework-sdkextensions.jar:/apex/com.android.tethering/javalib/framework-connectivity.jar:/apex/com.android.tethering/javalib/framework-connectivity-b.jar:/apex/com.android.tethering/javalib/framework-connectivity-t.jar:/apex/com.android.tethering/javalib/framework-tethering.jar:/apex/com.android.uwb/javalib/framework-ranging.jar:/apex/com.android.uwb/javalib/framework-uwb.jar:/apex/com.android.virt/javalib/framework-virtualization.jar:/apex/com.android.wifi/javalib/framework-wifi.jar:/apex/com.samsung.android.lifeguard/javalib/framework-lifeguard.jar:/apex/com.samsung.android.shell/javalib/framework-samsung-shell.jar
# COLORTERM=truecolor
# DEX2OATBOOTCLASSPATH=/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/framework-graphics.jar:/system/framework/framework-location.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/knoxsdk.jar:/system/framework/com.samsung.android.uwb_extras.jar:/system/framework/framework-platformcrashrecovery.jar:/system/framework/framework-ondeviceintelligence-platform.jar:/system/framework/framework-nfc.jar:/system/framework/tcmiface.jar:/system/framework/telephony-ext.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/esecomm.jar:/apex/com.android.i18n/javalib/core-icu4j.jar
# EXTERNAL_STORAGE=/sdcard
# LANG=en_US.UTF-8
# MOZ_FAKE_NO_SANDBOX=1
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin
# PULSE_SERVER=127.0.0.1
# TERM=xterm-256color
# TMPDIR=/tmp

# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/profile
# # /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# # and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).
# if [ "$(id -u)" -eq 0 ]; then
# 	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin"
# else
# 	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin"
# fi
# export PATH
# if [ "${PS1-}" ]; then
# if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
# 	# The file bash.bashrc already sets the default PS1.
# 	# PS1='\h:\w\$ '
# 	if [ -f /etc/bash.bashrc ]; then
# 		. /etc/bash.bashrc
# 	fi
# else
# 	if [ "$(id -u)" -eq 0 ]; then
# 		PS1='# '
# 	else
# 		PS1='$ '
#     fi
#   fi
# fi
# if [ -d /etc/profile.d ]; then
# 	for i in $(run-parts --list --regex '^[a-zA-Z0-9_][a-zA-Z0-9._-]*\.sh$' /etc/profile.d); do
#     if [ -r $i ]; then
#       . $i
#     fi
#   done
#   unset i
# fi
