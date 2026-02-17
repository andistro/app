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
	{
		for i in {1..50}; do
			sleep 0.1
			echo $((i * 2))
		done
	} | dialog --no-shadow --gauge "$label_distro_download_start" $dialog_height $dialog_width
	debootstrap --arch=$archurl --variant=minbase --include=dialog,sudo,wget,nano,locales,gpg,curl,ca-certificates $distro_version $folder http://deb.${distro_name}.org/${distro_name}/  2>&1 | dialog --no-shadow --title "${label_distro_download}" --progressbox $dialog_height $dialog_width
	{
		for i in {1..50}; do
			sleep 0.1
			echo $((i * 2))
		done
	} | dialog --no-shadow --gauge "$label_distro_download_finish" $dialog_height $dialog_width
fi

# Configurações pós-instalação
cp "$config_file/start-distro" $bin

sed -i "s|command+=\" LANG=\$system_icu_lang_code_env.UTF-8\"|command+=\" LANG=$system_icu_lang_code_env.UTF-8\"|g" $bin

chmod +x $bin

rm -rf $folder/root/.bash_profile
cp "$config_file/.bash_profile" $folder/root/.bash_profile

sed -i "s|distro_name=\"\$1\"|distro_name=\"$distro_name\"|g" $folder/root/.bash_profile
sed -i "s|distro_theme=\"\$2\"|distro_theme=\"$distro_theme\"|g" $folder/root/.bash_profile
sed -i "s|LANG=\"\$3\"|LANG=\"$system_icu_lang_code_env.UTF-8\"|g" $folder/root/.bash_profile
	
cp $config_file/system-config.sh $folder/root/system-config.sh

if [ "$config_environment" = "null" ]; then
	echo " "
elif [ "$config_environment" = "xfce4" ]; then
    # Coloque aqui o comando que você quer executar quando for XFCE4
	cp "$config_file/environment/$config_environment/config-environment.sh" "$folder/root/config-environment.sh"
	cp "$config_file/environment/$config_environment/xfce4-panel.tar.bz2" "$folder/root/xfce4-panel.tar.bz2"
else
	cp "$config_file/environment/$config_environment/config-environment.sh" "$folder/root/config-environment.sh"
fi


# Adicionar entradas em hosts, resolv.conf e timezone
cat << 'EOF' >> $folder/etc/hosts
# IPv4.
127.0.0.1   localhost.localdomain localhost
# IPv6.
::1         localhost.localdomain localhost ip6-localhost ip6-loopback
fe00::0     ip6-localnet
ff00::0     ip6-mcastprefix
ff02::1     ip6-allnodes
ff02::2     ip6-allrouters
ff02::3     ip6-allhosts
EOF

echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf > /dev/null 2>&1
echo "nameserver 8.8.4.4" | tee $folder/etc/resolv.conf > /dev/null 2>&1
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


# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/bash.bashrc
# # System-wide .bashrc file for interactive bash(1) shells.

# # To enable the settings / commands in this file for login shells as well,
# # this file has to be sourced in /etc/profile.

# # If not running interactively, don't do anything
# [ -z "${PS1-}" ] && return

# # check the window size after each command and, if necessary,
# # update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# # set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(< /etc/debian_chroot)
# fi

# # set a fancy prompt (non-color, overwrite the one in /etc/profile)
# # but only if not SUDOing and have SUDO_PS1 set; then assume smart user.
# if ! [ -n "${SUDO_USER-}" -a -n "${SUDO_PS1-}" ]; then
#   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi

# # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# # If this is an xterm set the title to user@host:dir
# #case "$TERM" in
# #xterm*|rxvt*)
# #    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
# #    ;;
# #*)
# #    ;;
# #esac

# # enable bash completion in interactive shells
# #if ! shopt -oq posix; then
# #  if [ -f /usr/share/bash-completion/bash_completion ]; then
# #    . /usr/share/bash-completion/bash_completion
# #  elif [ -f /etc/bash_completion ]; then
# #    . /etc/bash_completion
# #  fi
# #fi

# # if the command-not-found package is installed, use it
# if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
#         function command_not_found_handle {
#                 # check because c-n-f could've been removed in the meantime
#                 if [ -x /usr/lib/command-not-found ]; then
#                    /usr/lib/command-not-found -- "$1"
#                    return $?
#                 elif [ -x /usr/share/command-not-found/command-not-found ]; then
#                    /usr/share/command-not-found/command-not-found -- "$1"
#                    return $?
#                 else
#                    printf "%s: command not found\n" "$1" >&2
#                    return 127
#                 fi
#         }
# fi
# ~ $


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

# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/login.defs
# #
# # /etc/login.defs - Configuration control definitions for the shadow package.
# #
# # REQUIRED for useradd/userdel/usermod
# #   Directory where mailboxes reside, _or_ name of file, relative to the
# #   home directory.  If you _do_ define MAIL_DIR and MAIL_FILE,
# #   MAIL_DIR takes precedence.
# #   Essentially:
# #      - MAIL_DIR defines the location of users mail spool files
# #        (for mbox use) by appending the username to MAIL_DIR as defined
# #        below.
# #      - MAIL_FILE defines the location of the users mail spool files as the
# #        fully-qualified filename obtained by prepending the user home
# #        directory before $MAIL_FILE            #
# # NOTE: This is no more used for setting up users MAIL environment variable
# #       which is, starting from shadow 4.0.12-1 in Debian, entirely the
# #       job of the pam_mail PAM modules
# #       See default PAM configuration files provided for
# #       login, su, etc.
# #
# # This is a temporary situation: setting these variables will soon
# # move to /etc/default/useradd and the variables will then be
# # no more supported
# MAIL_DIR        /var/mail
# #MAIL_FILE      .mail

# #
# # Enable display of unknown usernames when login(1) failures are recorded.
# #
# # WARNING: Unknown usernames may become world readable.
# # See #290803 and #298773 for details about how this could become a security
# # concern
# LOG_UNKFAIL_ENAB        no

# #
# # Enable logging of successful logins
# #
# LOG_OK_LOGINS           no

# #
# # If defined, file which maps tty line to TERM environment parameter.
# # Each line of the file is in a format similar to "vt100  tty01".
# #
# #TTYTYPE_FILE   /etc/ttytype

# #
# # If defined, file which inhibits all the usual chatter during the login
# # sequence.  If a full pathname, then hushed mode will be enabled if the
# # user's name or shell are found in the file.  If not a full pathname, then
# # hushed mode will be enabled if the file exists in the user's home directory.
# #
# HUSHLOGIN_FILE  .hushlogin
# #HUSHLOGIN_FILE /etc/hushlogins

# #
# # *REQUIRED*  The default PATH settings, for superuser and normal users.
# #
# # (they are minimal, add the rest in the shell startup files)
# ENV_SUPATH      PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin"
# ENV_PATH        PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/data/data/com.termux/files/usr/bin:/system/bin:/system/xbin"

# #
# # Terminal permissions for terminals after login(1).
# # These settings are ignored for remote and other logins.
# #
# #       TTYGROUP        Login tty will be assigned this group ownership.
# #       TTYPERM         Login tty will be set to this permission.
# #
# #TTYGROUP       tty
# TTYPERM         0600

# #
# # Login configuration initializations:
# #
# #       ERASECHAR       Terminal ERASE character ('\010' = backspace).
# #       KILLCHAR        Terminal KILL character ('\025' = CTRL/U).
# #
# # The ERASECHAR and KILLCHAR are used only on System V machines.
# #
# ERASECHAR       0177
# KILLCHAR        025

# # HOME_MODE is used by useradd(8) and newusers(8) to set the mode for new
# # home directories.
# HOME_MODE       0700

# #
# # Password aging controls:
# #
# #       PASS_MAX_DAYS   Maximum number of days a password may be used.
# #       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
# #       PASS_WARN_AGE   Number of days warning given before a password expires.
# #
# PASS_MAX_DAYS   99999
# PASS_MIN_DAYS   0
# PASS_WARN_AGE   7

# #
# # Min/max values for automatic uid selection in useradd(8)
# #
# UID_MIN                  1000
# UID_MAX                 60000
# # System accounts
# #SYS_UID_MIN              101
# #SYS_UID_MAX              999
# # Extra per user uids
# SUB_UID_MIN                100000
# SUB_UID_MAX             600100000
# SUB_UID_COUNT               65536

# #
# # Min/max values for automatic gid selection in groupadd(8)
# #
# GID_MIN                  1000
# GID_MAX                 60000
# # System accounts
# #SYS_GID_MIN              101
# #SYS_GID_MAX              999
# # Extra per user group ids
# SUB_GID_MIN                100000
# SUB_GID_MAX             600100000
# SUB_GID_COUNT               65536

# #
# # Max number of login(1) retries if password is bad
# # This will most likely be overriden by PAM, since the default pam_unix module
# # has it's own built in of 3 retries. However, this is a safe fallback in case
# # you are using an authentication module that does not enforce PAM_MAXTRIES.
# #
# LOGIN_RETRIES           5

# #
# # Max time in seconds for login(1)
# #
# LOGIN_TIMEOUT           60

# #
# # Which fields may be changed by regular users using chfn(1) - use
# # any combination of letters "frwh" (full name, room number, work
# # phone, home phone).  If not defined, no changes are allowed.
# # For backward compatibility, "yes" = "rwh" and "no" = "frwh".
# #
# CHFN_RESTRICT           rwh

# #
# # If set to MD5, MD5-based algorithm will be used for encrypting password
# # If set to SHA256, SHA256-based algorithm will be used for encrypting password
# # If set to SHA512, SHA512-based algorithm will be used for encrypting password
# # If set to BCRYPT, BCRYPT-based algorithm will be used for encrypting password
# # If set to YESCRYPT, YESCRYPT-based algorithm will be used for encrypting password
# # If set to DES, DES-based algorithm will be used for encrypting password (default)
# # MD5 and DES should not be used for new hashes, see crypt(5) for recommendations.
# # Overrides the MD5_CRYPT_ENAB option
# #
# # Note: It is recommended to use a value consistent with
# # the PAM modules configuration.
# #
# ENCRYPT_METHOD YESCRYPT

# #
# # Should login be allowed if we can't cd to the home directory?
# # Default is no.
# #
# DEFAULT_HOME    yes

# #
# # The pwck(8) utility emits a warning for any system account with a home
# # directory that does not exist.  Some system accounts intentionally do
# # not have a home directory.  Such accounts may have this string as
# # their home directory in /etc/passwd to avoid a spurious warning.
# #
# NONEXISTENT     /nonexistent

# #
# # If defined, this command is run when removing a user.
# # It should remove any at/cron/print jobs etc. owned by
# # the user to be removed (passed as the first argument).
# #
# #USERDEL_CMD    /usr/sbin/userdel_local

# #
# # If set to yes, userdel(8) will remove the user's group if it contains no more
# # members, and useradd(8) will create by default a group with the name of the
# # user.
# #
# # Other former uses of this variable are not used in PAM environments, such as
# # Debian.
# #
# USERGROUPS_ENAB yes

# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/resolv.conf
# nameserver 8.8.8.8
# nameserver 8.8.4.4


# ~ $ cat /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/debian/etc/hosts
# # IPv4.
# 127.0.0.1   localhost.localdomain localhost
# # IPv6.
# ::1         localhost.localdomain localhost ip6-localhost ip6-loopback
# fe00::0     ip6-localnet
# ff00::0     ip6-mcastprefix
# ff02::1     ip6-allnodes
# ff02::2     ip6-allrouters
# ff02::3     ip6-allhosts