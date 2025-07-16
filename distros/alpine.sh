#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
bin="start-alpine.sh"
codinome="edge"
folder="alpine-edge"
binds="alpine-binds"

#=============================================================================================
# Caso a versão do debian já tenha sido baixada, não baixar novamente
if [ -d "$folder" ]; then
	first=1
	echo "${label_skip_download}"
fi

sleep 2
# Baixa
if [ "$first" != 1 ];then
	case `dpkg --print-architecture` in
	aarch64)
		archurl="arm64" ;;
	arm)
		archurl="armhf" ;;
	*)
		echo "unknown architecture"; exit 1 ;;
	esac
	show_progress_dialog wget "${label_alpine_download}" 1 -O $folder.tar.xz "${extralink}/distros/files/dists/${archurl}/alpine/${codinome}/installer.tar.xz"
	sleep 2
	show_progress_dialog extract "${label_alpine_download_extract}" "$HOME/$folder.tar.xz"
	sleep 2
fi

cat > $bin <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash
	cd \$(dirname \$0)
	## unset LD_PRELOAD in case termux-exec is installed
	unset LD_PRELOAD
	command="proot"
	command+=" --link2symlink"
	command+=" -0"
	command+=" -r $folder"
	if [ -n "\$(ls -A $binds)" ]; then
    		for f in $binds/* ;do
      		. \$f
    	done
	fi
	command+=" -b /dev"
	command+=" -b /proc"
	command+=" -b $folder/root:/dev/shm"
	## uncomment the following line to have access to the home directory of termux
	#command+=" -b /data/data/com.termux/files/home:/root"
	## uncomment the following line to mount /sdcard directly to /
	#command+=" -b /sdcard"
	command+=" -w /root"
	command+=" /usr/bin/env -i"
	command+=" HOME=/root"
	command+=" PATH=/bin:/usr/bin:/sbin:/usr/sbin"
	command+=" TERM=\$TERM"
	command+=" LANG=en_US.UTF-8"
	command+=" LC_ALL=C"
	command+=" LANGUAGE=en_US"
	command+=" /bin/sh --login"
	com="\$@"
	if [ -z "\$1" ];then
    		exec \$command
	else
    		\$command -c "\$com"
	fi
	EOM

chmod +x $bin

echo "" > $folder/etc/fstab
rm -rf $folder/etc/resolv.conf
echo nameserver 8.8.8.8 > $folder/etc/resolv.conf

./$bin apk update
        ./$bin apk add --no-cache bash
        sed -i 's/ash/bash/g' $folder/etc/passwd
        sed -i 's/bin\/sh/bin\/bash/g' $bin
	echo "Installation Finished"
	rm -rf $folder/root/.bash_profile
  	echo "#!/bin/bash
              wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Alpine/alpine-xfce.sh -O /root/alpine-xfce.sh
              bash /root/alpine-xfce.sh
              rm -rf /root/alpine-xfce.sh
              clear" > $folder/root/.bash_profile  
   	bash $bin