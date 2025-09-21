#!/bin/bash
## Cria o diretório de armazenamento, se não existir
if [ ! -d "$HOME/storage" ];then
    termux-setup-storage
fi

## Define a DPI do dispositivo
#device_dpi=$(getprop ro.sf.lcd_density 2>/dev/null)
#mkdir -p /data/data/com.termux/files/usr/var/lib/andistro/boot/debian/trixie/.Xresources
#echo "Xft.dpi: $device_dpi" > /data/data/com.termux/files/usr/var/lib/andistro/boot/debian/trixie/.Xresources

## Copia o meminfo atual para dentro do ambiente proot
#meminfo=$(cat /proc/meminfo)
#echo "$meminfo" >> /data/data/com.termux/files/usr/var/lib/andistro/boot/debian/trixie/proc/meminfo

#cd $(dirname $0)
cd $HOME

pulseaudio --start

## Remove a variável de ambiente LD_PRELOAD caso o termux-exec esteja instalado.
unset LD_PRELOAD

command="proot"
command+=" --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r /data/data/com.termux/files/usr/var/lib/andistro/boot/debian/trixie"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b /sys"
command+=" -b /data"
command+=" -b /proc/meminfo:/proc/meminfo"
command+=" -b /data/data/com.termux/files/usr/var/lib/andistro/boot/debian/trixie/root:/dev/shm"
command+=" -b /proc/self/fd/2:/dev/stderr"
command+=" -b /proc/self/fd/1:/dev/stdout"
command+=" -b /proc/self/fd/0:/dev/stdin"
command+=" -b /dev/urandom:/dev/random"
command+=" -b /proc/self/fd:/dev/fd"
## Descomente a linha a seguir para ter acesso ao diretório raiz do termux
#command+=" -b /data/data/com.termux/files/home:/root"
command+=" -b /data/data/com.termux/files/home:/termux-home"
command+=" -b /data/data/com.termux/files/usr/bin:/bin/termux-bin"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" MOZ_FAKE_NO_SANDBOX=1"
command+=" HOME=/root"
command+=" DISPLAY=:1"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
#command+=" LANG=C.UTF-8"
command+=" LANG=pt_BR.UTF-8"
command+=" /bin/bash --login"
command+=" -b /usr/local/bin/startvncserver"
com="$@"
if [ -z "$1" ]; then
    exec $command
else
    $command -c "$com"
fi
