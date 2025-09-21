#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"

show_progress_dialog steps-multi-label 61 \
  "${label_progress}" 'sudo apt clean' \
  "${label_find_update}" 'sudo apt update' \
  "${label_upgrade}" 'sudo apt full-upgrade -y' \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install tzdata --no-install-recommends -y" \
  "${label_install_script_download}" "sudo DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration --no-install-recommends -y" \
  "${label_install_script_download}\n\n → xz-utils" 'sudo apt install xz-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → wget" 'sudo apt install wget --no-install-recommends -y' \
  "${label_install_script_download}\n\n → curl" 'sudo apt install curl --no-install-recommends -y' \
  "${label_install_script_download}\n\n → gpg" 'sudo apt install gpg --no-install-recommends -y' \
  "${label_install_script_download}\n\n → git" 'sudo apt install git --no-install-recommends -y' \
  "${label_install_script_download}\n\n → python3" 'sudo apt install python3 --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tar" 'sudo apt install tar --no-install-recommends -y' \
  "${label_install_script_download}\n\n → unzip" 'sudo apt install unzip --no-install-recommends -y' \
  "${label_install_script_download}\n\n → zip" 'sudo apt install zip --no-install-recommends -y' \
  "${label_install_script_download}\n\n → apt-utils" 'sudo apt install apt-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → lsb-release" 'sudo apt install lsb-release --no-install-recommends -y' \
  "${label_install_script_download}\n\n → exo-utils" 'sudo apt install exo-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-standalone-server" 'sudo apt install tigervnc-standalone-server --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-common" 'sudo apt install tigervnc-common --no-install-recommends -y' \
  "${label_install_script_download}\n\n → tigervnc-tools" 'sudo apt install tigervnc-tools --no-install-recommends -y' \
  "${label_install_script_download}\n\n → dbus-x11" 'sudo apt install dbus-x11 --no-install-recommends -y' \
  "${label_install_script_download}\n\n → nano" 'sudo apt install nano --no-install-recommends -y' \
  "${label_install_script_download}\n\n → inetutils-tools" 'sudo apt install inetutils-tools --no-install-recommends -y' \
  "${label_install_script_download}\n\n → font-manager" 'sudo apt install font-manager --no-install-recommends -y' \
  "${label_install_script_download}\n\n → synaptic" 'sudo apt install synaptic --no-install-recommends -y' \
  "${label_install_script_download}\n\n → gvfs-backends" 'sudo apt install gvfs-backends --no-install-recommends -y' \
  "${label_install_script_download}\n\n → bleachbit" 'sudo apt install bleachbit --no-install-recommends -y' \
  "${label_install_script_download}\n\n → xz-utils" 'sudo apt install xz-utils --no-install-recommends -y' \
  "${label_install_script_download}\n\n → pulseaudio" 'sudo apt install pulseaudio --no-install-recommends -y' \
  "${label_install_script_download}" 'sudo install -d -m 0755 /etc/apt/keyrings' \
  "${label_install_script_download}\n\n → firefox" 'wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null' \
  "${label_install_script_download}\n\n → firefox" 'echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list' \
  "${label_install_script_download}\n\n → firefox" 'echo -e "\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" | sudo tee /etc/apt/preferences.d/mozilla' \
  "${label_install_script_download}\n\n → firefox" 'sudo apt update && sleep 2' \
  "${label_install_script_download}\n\n → firefox" 'sudo apt install firefox --no-install-recommends -y' \
  "${label_install_script_download}\n\n → code" 'wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg' \
  "${label_install_script_download}\n\n → code" 'sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg' \
  "${label_install_script_download}\n\n → code" "echo 'deb [arch=arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list" \
  "${label_install_script_download}\n\n → code" 'rm -f packages.microsoft.gpg' \
  "${label_install_script_download}\n\n → code" 'sudo apt update && sleep 2' \
  "${label_install_script_download}\n\n → code" 'sudo apt install code --no-install-recommends -y' \
  "${label_install_script_download}\n\n → code" "sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|' /usr/share/applications/code*.desktop" \
  "${label_install_script_download}" 'sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg' \
  "${label_install_script_download}" 'echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list' \
  "${label_install_script_download}" 'sudo apt update && sleep 2' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-icon-themes.git' \
  "${label_install_script_download}" 'git clone https://github.com/ZorinOS/zorin-desktop-themes.git' \
  "${label_install_script_download}" 'sleep 5' \
  "${label_system_setup}\n\n → synaptic" "sudo sed -i 's/^Exec=synaptic-pkexec/Exec=synaptic/' /usr/share/applications/synaptic.desktop" \
  "${label_system_setup}" 'mkdir -p "/usr/share/backgrounds/"' \
  "${label_system_setup}" 'mkdir -p "/usr/share/icons/"' \
  "${label_system_setup}" 'mkdir -p "$HOME/.config/gtk-3.0"' \
  "${label_system_setup}" 'echo -e "file:/// raiz\nfile:///sdcard sdcard" | sudo tee $HOME/.config/gtk-3.0/bookmarks' \
  "${label_system_setup}" 'mv zorin-icon-themes/Zorin*/ /usr/share/icons/' \
  "${label_system_setup}" 'mv zorin-desktop-themes/Zorin*/ /usr/share/themes/' \
  "${label_system_setup}" 'rm -rf zorin-*-themes/' \
  "${label_system_setup}" "echo -e '[Settings]\\ngtk-theme-name=ZorinBlue-Dark' | sudo tee $HOME/.config/gtk-3.0/settings.ini" \
  "${label_system_setup}" "echo 'gtk-theme-name=\"ZorinBlue-Dark\"' | sudo tee $HOME/.gtkrc-2.0" \
  "${label_system_setup}" 'sudo apt-get clean' \
  "${label_system_setup}" 'sudo dpkg --configure -a ' \
  "${label_system_setup}" 'sudo apt --fix-broken install -y'
sleep 2

{
 for i in {1..50}; do
   sleep 0.1
   echo $((i * 2))
 done
} | dialog --no-shadow --gauge "$label_keyboard_setup" 10 60 0
sudo dpkg-reconfigure keyboard-configuration

rm -rf system-config.sh

# sudo apt install brave-browser --no-install-recommends -y
# sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/brave-browser.desktop
# sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/com.brave.Browser.desktop
# sudo apt install xz-utils wget  curl  gpg git tar unzip zip apt-utils lsb-release exo-utils dbus-x11 nano inetutils-tools font-manager synaptic gvfs-backends at-spi2-core bleachbit --no-install-recommends
# Atualizando:
#   libsystemd0  libudev1

# Instalando:
#   apt-utils     font-manager     nano
#   at-spi2-core  git              synaptic
#   bleachbit     gpg              unzip
#   curl          gvfs-backends    xz-utils
#   dbus-x11      inetutils-tools  zip
#   exo-utils     lsb-release

# Instalando dependências:
#   adduser
#   adwaita-icon-theme
#   at-spi2-common
#   bubblewrap
#   dbus
#   dbus-bin
#   dbus-daemon
#   dbus-session-bus-common
#   dbus-system-bus-common
#   dconf-gsettings-backend
#   dconf-service
#   desktop-file-utils
#   dictionaries-common
#   dmsetup
#   emacsen-common
#   font-manager-common
#   font-viewer
#   fontconfig
#   fontconfig-config
#   fonts-dejavu-core
#   fonts-dejavu-mono
#   gir1.2-atk-1.0
#   gir1.2-freedesktop
#   gir1.2-gdkpixbuf-2.0
#   gir1.2-girepository-2.0
#   gir1.2-glib-2.0
#   gir1.2-gtk-3.0
#   gir1.2-harfbuzz-0.0
#   gir1.2-notify-0.7
#   gir1.2-pango-1.0
#   git-man
#   glib-networking
#   glib-networking-common
#   glib-networking-services
#   gpgconf
#   gsettings-desktop-schemas
#   gstreamer1.0-plugins-base
#   gstreamer1.0-plugins-good
#   gtk-update-icon-cache
#   gvfs
#   gvfs-common
#   gvfs-daemons
#   gvfs-libs
#   hicolor-icon-theme
#   hunspell-en-us
#   iso-codes
#   libaa1
#   libabsl20240722
#   libadwaita-1-0
#   libaom3
#   libappstream5
#   libarchive13t64
#   libasound2-data
#   libasound2t64
#   libaspell15
#   libassuan9
#   libasyncns0
#   libatasmart4
#   libatk-bridge2.0-0t64
#   libatk1.0-0t64
#   libatomic1
#   libatspi2.0-0t64
#   libavahi-client3
#   libavahi-common-data
#   libavahi-common3
#   libavahi-glib1
#   libavc1394-0
#   libavif16
#   libblockdev-crypto3
#   libblockdev-fs3
#   libblockdev-loop3
#   libblockdev-mdraid3
#   libblockdev-nvme3
#   libblockdev-part3
#   libblockdev-swap3
#   libblockdev-utils3
#   libblockdev3
#   libbluray2
#   libbrotli1
#   libbytesize-common
#   libbytesize1
#   libcaca0
#   libcairo-gobject2
#   libcairo-script-interpreter2
#   libcairo2
#   libcap2-bin
#   libcdio-cdda2t64
#   libcdio-paranoia2t64
#   libcdio19t64
#   libcdparanoia0
#   libcloudproviders0
#   libcolord2
#   libcom-err2
#   libcryptsetup12
#   libcups2t64
#   libcurl3t64-gnutls
#   libcurl4t64
#   libdatrie1
#   libdav1d7
#   libdbus-1-3
#   libdconf1
#   libde265-0
#   libdeflate0
#   libdevmapper1.02.1
#   libdrm-amdgpu1
#   libdrm-common
#   libdrm2
#   libduktape207
#   libdv4t64
#   libedit2
#   libegl-mesa0
#   libegl1
#   libelf1t64
#   libenchant-2-2
#   libepoxy0
#   liberror-perl
#   libevdev2
#   libexif12
#   libexo-2-0
#   libexo-common
#   libexpat1
#   libext2fs2t64
#   libfdisk1
#   libflac14
#   libflite1
#   libfontconfig1
#   libfreetype6
#   libfribidi0
#   libgav1-1
#   libgbm1
#   libgck-2-2
#   libgcr-4-4
#   libgcrypt20
#   libgd3
#   libgdata-common
#   libgdata22
#   libgdbm-compat4t64
#   libgdbm6t64
#   libgdk-pixbuf-2.0-0
#   libgdk-pixbuf2.0-common
#   libgirepository-1.0-1
#   libgl1
#   libgl1-mesa-dri
#   libgles2
#   libglib2.0-0t64
#   libglvnd0
#   libglx-mesa0
#   libglx0
#   libgoa-1.0-0b
#   libgoa-1.0-common
#   libgomp1
#   libgpg-error0
#   libgpgme11t64
#   libgphoto2-6t64
#   libgphoto2-port12t64
#   libgraphene-1.0-0
#   libgraphite2-3
#   libgssapi-krb5-2
#   libgssdp-1.6-0
#   libgstreamer-gl1.0-0
#   libgstreamer-plugins-bad1.0-0
#   libgstreamer-plugins-base1.0-0
#   libgstreamer1.0-0
#   libgtk-3-0t64
#   libgtk-3-common
#   libgtk-4-1
#   libgtk-4-common
#   libgudev-1.0-0
#   libgupnp-1.6-0
#   libgupnp-igd-1.6-0
#   libharfbuzz-gobject0
#   libharfbuzz-icu0
#   libharfbuzz-subset0
#   libharfbuzz0b
#   libheif-plugin-dav1d
#   libheif-plugin-libde265
#   libheif1
#   libhidapi-hidraw0
#   libhunspell-1.7-0
#   libhwy1t64
#   libhyphen0
#   libice6
#   libicu76
#   libiec61883-0
#   libimagequant0
#   libimobiledevice-1.0-6
#   libimobiledevice-glue-1.0-0
#   libjansson4
#   libjavascriptcoregtk-6.0-1
#   libjbig0
#   libjpeg62-turbo
#   libjson-c5
#   libjson-glib-1.0-0
#   libjson-glib-1.0-common
#   libjxl0.11
#   libk5crypto3
#   libkeyutils1
#   libkmod2
#   libkrb5-3
#   libkrb5support0
#   libksba8
#   liblcms2-2
#   libldap2
#   libldb2
#   liblerc4
#   libllvm19
#   liblmdb0
#   liblsof0
#   libltdl7
#   liblzo2-2
#   libmanette-0.2-0
#   libmp3lame0
#   libmpfr6
#   libmpg123-0t64
#   libmsgraph-1-1
#   libmtp-common
#   libmtp9t64
#   libncurses6
#   libnfs14
#   libnghttp2-14
#   libnghttp3-9
#   libngtcp2-16
#   libngtcp2-crypto-gnutls8
#   libnice10
#   libnotify4
#   libnpth0t64
#   libnspr4
#   libnss3
#   libnvme1t64
#   libogg0
#   libopencore-amrnb0
#   libopencore-amrwb0
#   libopus0
#   liborc-0.4-0t64
#   libpam-systemd
#   libpango-1.0-0
#   libpangocairo-1.0-0
#   libpangoft2-1.0-0
#   libpangoxft-1.0-0
#   libparted2t64
#   libperl5.40
#   libpixman-1-0
#   libplist-2.0-4
#   libpng16-16t64
#   libpolkit-agent-1-0
#   libpolkit-gobject-1-0
#   libpopt0
#   libproc2-0
#   libproxy1v5
#   libpulse0
#   libpython3-stdlib
#   libpython3.13-minimal
#   libpython3.13-stdlib
#   librav1e0.7
#   libraw1394-11
#   libreadline8t64
#   librtmp1
#   libsasl2-2
#   libsasl2-modules-db
#   libsecret-1-0
#   libsecret-common
#   libsensors-config
#   libsensors5
#   libsharpyuv0
#   libshout3
#   libslang2
#   libsm6
#   libsmbclient0
#   libsndfile1
#   libsoup-2.4-1
#   libsoup-3.0-0
#   libsoup-3.0-common
#   libsoup2.4-common
#   libspeex1
#   libssh2-1t64
#   libstartup-notification0
#   libstemmer0d
#   libsvtav1enc2
#   libsystemd-shared
#   libtag2
#   libtalloc2
#   libtdb1
#   libtevent0t64
#   libtext-iconv-perl
#   libthai-data
#   libthai0
#   libtheora0
#   libtheoradec1
#   libtheoraenc1
#   libtiff6
#   libtirpc-common
#   libtirpc3t64
#   libtwolame0
#   libudfread0
#   libudisks2-0
#   libusb-1.0-0
#   libusbmuxd-2.0-7
#   libv4l-0t64
#   libv4lconvert0t64
#   libva-drm2
#   libva2
#   libvisual-0.4-0
#   libvolume-key1
#   libvorbis0a
#   libvorbisenc2
#   libvpx9
#   libvte-2.91-0
#   libvte-2.91-common
#   libvulkan1
#   libwavpack1
#   libwayland-client0
#   libwayland-cursor0
#   libwayland-egl1
#   libwayland-server0
#   libwbclient0
#   libwebkitgtk-6.0-4
#   libwebp7
#   libwebpdemux2
#   libwebpmux3
#   libwoff1
#   libx11-6
#   libx11-data
#   libx11-xcb1
#   libxau6
#   libxcb-dri3-0
#   libxcb-glx0
#   libxcb-present0
#   libxcb-randr0
#   libxcb-render0
#   libxcb-shm0
#   libxcb-sync1
#   libxcb-util1
#   libxcb-xfixes0
#   libxcb-xkb1
#   libxcb1
#   libxcomposite1
#   libxcursor1
#   libxdamage1
#   libxdmcp6
#   libxext6
#   libxfce4ui-2-0
#   libxfce4ui-common
#   libxfce4util-common
#   libxfce4util7
#   libxfconf-0-3
#   libxfixes3
#   libxft2
#   libxi6
#   libxinerama1
#   libxkbcommon-x11-0
#   libxkbcommon0
#   libxml2
#   libxmlb2
#   libxpm4
#   libxrandr2
#   libxrender1
#   libxshmfence1
#   libxslt1.1
#   libxtst6
#   libxxf86vm1
#   libyaml-0-2
#   libyuv0
#   libz3-4
#   lsof
#   media-types
#   mesa-libgallium
#   netbase
#   parted
#   perl
#   perl-modules-5.40
#   pkexec
#   polkitd
#   procps
#   psmisc
#   python3
#   python3-certifi
#   python3-chardet
#   python3-charset-normalizer
#   python3-gi
#   python3-idna
#   python3-minimal
#   python3-requests
#   python3-urllib3
#   python3.13
#   python3.13-minimal
#   readline-common
#   samba-libs
#   sgml-base
#   shared-mime-info
#   systemd
#   systemd-sysv
#   udev
#   udisks2
#   x11-common
#   xdg-dbus-proxy
#   xfconf
#   xkb-data
#   xml-core