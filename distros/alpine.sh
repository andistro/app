#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
bin="start-alpine.sh"
codinome="edge"
folder="alpine-edge"

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