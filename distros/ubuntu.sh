#!/data/data/com.termux/files/usr/bin/bash
source "$PREFIX/bin/andistro_files/global_var_fun.sh"
bin="start-ubuntu.sh"
codinome="noble"
folder="ubuntu-noble"
binds="ubuntu-binds"

# Idioma
# Verificar se o idioma do sistema está disponível, senão usar fallback
if [[ -n "${LANG_CODES[$system_icu_locale_code]}" ]]; then
    system_lang_code="$system_icu_locale_code"
else
    system_lang_code="en-US"
fi

# Construir a lista de opções
OPTIONS=()
# Adicionar idioma detectado como primeiro item
OPTIONS+=("auto" "→ ${LANG_CODES[$system_lang_code]} $label_detected")

# Separador visual (dialog ignora a opção com tag "--")
OPTIONS+=("--" "────────────")

# Adicionar os demais em ordem alfabética (excluindo o detectado)
for code in $(printf "%s\n" "${!LANG_CODES[@]}" | sort); do
    [[ "$code" == "$system_lang_code" ]] && continue
    OPTIONS+=("$code" "${LANG_CODES[$code]}")
done

# Mostrar menu
CHOICE=$(dialog --clear \
    --title "$MENU_language_select" \
    --menu "$MENU_language_select" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
    "${OPTIONS[@]}" \
    2>&1 >/dev/tty)

clear

# Determinar o idioma selecionado
if [[ "$CHOICE" == "auto" || -z "$CHOICE" ]]; then
    language_selected="$system_lang_code"
else
    language_selected="$CHOICE"
fi

# Exemplo: mostrar idioma escolhido
#echo "Idioma selecionado: $language_selected"
dialog --msgbox "$MENU_language_selected $language_selected" 10 70 0

language_transformed="${language_selected//-/_}"

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
	error_code="DW001deb"
	show_progress_dialog wget "${label_ubuntu_download}" 1 -O $folder.tar.xz "${extralink}/distros/files/dists/${archurl}/ubuntu/${codinome}/installer.tar.xz"
	sleep 2
	show_progress_dialog extract "${label_ubuntu_download_extract}" "$HOME/$folder.tar.xz"
	#rm -rf $folder/snap/
	sleep 2
fi

mkdir -p $binds
mkdir -p ${folder}/proc/fakethings

echo "${label_start_script}"

if [ ! -f "${HOME}/${folder}/proc/fakethings/stat" ]; then
	cat <<- EOF > "${HOME}/${folder}/proc/fakethings/stat"
cpu  5502487 1417100 4379831 62829678 354709 539972 363929 0 0 0
cpu0 611411 171363 667442 7404799 61301 253898 205544 0 0 0
cpu1 660993 192673 571402 7853047 39647 49434 29179 0 0 0
cpu2 666965 186509 576296 7853110 39012 48973 26407 0 0 0
cpu3 657630 183343 573805 7863627 38895 48768 26636 0 0 0
cpu4 620516 161440 594973 7899146 39438 47605 26467 0 0 0
cpu5 610849 155665 594684 7912479 40258 46870 26044 0 0 0
cpu6 857685 92294 387182 8096756 46609 22110 12364 0 0 0
cpu7 816434 273809 414043 7946709 49546 22311 11284 0 0 0
intr 601715486 0 0 0 0 70612466 0 2949552 0 93228 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12862684 625329 10382717 16209 55315 8510 0 0 0 0 11 11 13 270 192 40694 95 7 0 0 0 36850 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 286 6378 0 0 0 54 0 3239423 2575191 82725 0 0 127 0 0 0 1791277 850609 20 9076504 0 301 0 0 0 0 0 3834621 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 806645 0 0 0 0 0 7243 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2445850 52 1783 0 0 5091520 0 0 0 3 0 0 0 0 0 5475 0 198001 0 2 42 1289224 0 2 202483 4 0 8390 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3563336 4202122 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 0 1 0 1 0 17948 0 0 612 0 0 0 0 2103 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 11 11 12 0 12 0 52 752 0 0 0 0 0 0 0 743 0 14 0 0 12 0 0 1863 229 0 464 0 0 0 0 0 0 8588 97 7236426 92766 622 31 0 0 0 18 4 4 0 5 0 0 116013 7 0 0 752406
ctxt 826091808
btime 1611513513
processes 288493
procs_running 1
procs_blocked 0
softirq 175407567 14659158 51739474 28359 5901272 8879590 0 11988166 46104015 0 36107533
	EOF
fi

KERNEL_VERSON=$(uname -r)
if [ ! -f "${HOME}/${folder}/proc/fakethings/version" ]; then
	cat <<- EOF > "${HOME}/${folder}/proc/fakethings/version"
	$KERNEL_VERSION (FakeAndroid) #1 SMP PREEMPT Sat Apr  5 02:10:31 -03 2025
	EOF
fi

if [ ! -f "${HOME}/${folder}/proc/fakethings/vmstat" ]; then
	cat <<- EOF > "${HOME}/${folder}/proc/fakethings/vmstat"
	nr_free_pages 15717
	nr_zone_inactive_anon 87325
	nr_zone_active_anon 259521
	nr_zone_inactive_file 95508
	nr_zone_active_file 57839
	nr_zone_unevictable 58867
	nr_zone_write_pending 0
	nr_mlock 58867
	nr_page_table_pages 24569
	nr_kernel_stack 49552
	nr_bounce 0
	nr_zspages 80896
	nr_free_cma 0
	nr_inactive_anon 87325
	nr_active_anon 259521
	nr_inactive_file 95508
	nr_active_file 57839
	nr_unevictable 58867
	nr_slab_reclaimable 17709
	nr_slab_unreclaimable 47418
	nr_isolated_anon 0
	nr_isolated_file 0
	workingset_refault 33002180
	workingset_activate 5498395
	workingset_restore 2354202
	workingset_nodereclaim 140006
	nr_anon_pages 344014
	nr_mapped 193745
	nr_file_pages 218441
	nr_dirty 0
	nr_writeback 0
	nr_writeback_temp 0
	nr_shmem 1880
	nr_shmem_hugepages 0
	nr_shmem_pmdmapped 0
	nr_anon_transparent_hugepages 0
	nr_unstable 0
	nr_vmscan_write 8904094
	nr_vmscan_immediate_reclaim 139732
	nr_dirtied 8470080
	nr_written 16835370
	nr_indirectly_reclaimable 8273152
	nr_unreclaimable_pages 130861
	nr_dirty_threshold 31217
	nr_dirty_background_threshold 15589
	pgpgin 198399484
	pgpgout 31742368
	pgpgoutclean 45542744
	pswpin 3843200
	pswpout 8903884
	pgalloc_dma 192884869
	pgalloc_normal 190990320
	pgalloc_movable 0
	allocstall_dma 0
	allocstall_normal 3197
	allocstall_movable 1493
	pgskip_dma 0
	pgskip_normal 0
	pgskip_movable 0
	pgfree 384653565
	pgactivate 34249517
	pgdeactivate 44271435
	pglazyfree 192
	pgfault 46133667
	pgmajfault 5568301
	pglazyfreed 0
	pgrefill 55909145
	pgsteal_kswapd 58467386
	pgsteal_direct 255950
	pgscan_kswapd 86628315
	pgscan_direct 415889
	pgscan_direct_throttle 0
	pginodesteal 18
	slabs_scanned 31242197
	kswapd_inodesteal 1238474
	kswapd_low_wmark_hit_quickly 11637
	kswapd_high_wmark_hit_quickly 5411
	pageoutrun 32167
	pgrotated 213328
	drop_pagecache 0
	drop_slab 0
	oom_kill 0
	pgmigrate_success 729722
	pgmigrate_fail 450
	compact_migrate_scanned 43510584
	compact_free_scanned 248175096
	compact_isolated 1494774
	compact_stall 6
	compact_fail 3
	compact_success 3
	compact_daemon_wake 9438
	compact_daemon_migrate_scanned 43502436
	compact_daemon_free_scanned 248107303
	unevictable_pgs_culled 66418
	unevictable_pgs_scanned 0
	unevictable_pgs_rescued 8484
	unevictable_pgs_mlocked 78830
	unevictable_pgs_munlocked 8508
	unevictable_pgs_cleared 11455
	unevictable_pgs_stranded 11455
	swap_ra 0
	swap_ra_hit 7
	speculative_pgfault 221449963
	EOF
fi

cat > $bin <<- EOM
#!/bin/bash
#cd \$(dirname \$0)
cd $HOME
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --kill-on-exit"
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
command+=" -b /sys"
command+=" -b /data"
command+=" -b $folder/root:/dev/shm"
command+=" -b /proc/self/fd/2:/dev/stderr"
command+=" -b /proc/self/fd/1:/dev/stdout"
command+=" -b /proc/self/fd/0:/dev/stdin"
command+=" -b /dev/urandom:/dev/random"
command+=" -b /proc/self/fd:/dev/fd"
command+=" -b ${HOME}/${folder}/proc/fakethings/stat:/proc/stat"
command+=" -b ${HOME}/${folder}/proc/fakethings/vmstat:/proc/vmstat"
command+=" -b ${HOME}/${folder}/proc/fakethings/version:/proc/version"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" MOZ_FAKE_NO_SANDBOX=1"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "127.0.0.1 localhost localhost" > $folder/etc/hosts
rm -f $folder/etc/resolv.conf
echo -e 'nameserver 8.8.8.8\nnameserver 1.1.1.1' > $folder/etc/resolv.conf

# Se não existir, será criado
if [ ! -d "$folder/usr/share/backgrounds/" ];then
	mkdir -p "$folder/usr/share/backgrounds/"
	echo "pasta criada"
fi

if [ ! -d "$folder/usr/share/icons/" ];then
	mkdir -p "$folder/usr/share/icons/"
	echo "pasta criada"
fi

if [ ! -d "$folder/root/.vnc/" ];then
	mkdir -p $folder/root/.vnc/
	echo "pasta criada"
fi

show_progress_dialog wget-labeled "${label_progress}" 10 \
	"${label_progress}" -O "$folder/root/system-config.sh" "${extralink}/config/package-manager-setups/apt/system-config.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/global_var_fun.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/locale/l10n_${language_transformed}.sh" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/vnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/vncpasswd" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/startvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/stopvnc" \
	"${label_progress}" -P "$folder/usr/local/bin" "${extralink}/config/package-manager-setups/apt/vnc/startvncserver" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/john-towner-JgOeRuGD_Y4.jpg" \
	"${label_wallpaper_download}" -P "$folder/usr/share/backgrounds" "${extralink}/config/wallpapers/unsplash/wai-hsuen-chan-DnmMLipPktY.jpg"

chmod +x $folder/usr/local/bin/vnc
chmod +x $folder/usr/local/bin/vncpasswd
chmod +x $folder/usr/local/bin/startvnc
chmod +x $folder/usr/local/bin/stopvnc
chmod +x $folder/usr/local/bin/startvncserver
chmod +x "$folder/usr/local/bin/global_var_fun.sh"
chmod +x "$folder/usr/local/bin/l10n_${language_transformed}.sh"
chmod +x "$folder/root/system-config.sh"
sed -i "s/system_icu_locale_code=.*$/system_icu_locale_code=\"${language_selected}\"/" "$folder/usr/local/bin/global_var_fun.sh"
sleep 2

#echo "fixing shebang of $bin"
#termux-fix-shebang $bin
#echo "making $bin executable"
chmod +x $bin


export USER=$(whoami)
export PORT=1
OPTIONS=(1 "LXDE"
		 2 "XFCE"
		 3 "Gnome")

CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --menu "$MENU_environments_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
	1)	
		echo "LXDE UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/lxde/config.sh"
		sleep 2
		;;
	2)	
		echo "XFCE UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/xfce4/config.sh"
		sleep 2
		;;
	3)
		echo "Gnome UI"
		show_progress_dialog "wget" "${label_config_environment_gui}" 1 -O "$folder/root/config-environment.sh" "${extralink}/config/package-manager-setups/apt/environment/gnome/config.sh"
		sleep 2
		# Parte da resolução do problema do gnome e do systemd
		if [ ! -d "/data/data/com.termux/files/usr/var/run/dbus" ];then
			mkdir /data/data/com.termux/files/usr/var/run/dbus # criar a pasta que o dbus funcionará
			echo "pasta criada"
		fi
		#mkdir /data/data/com.termux/files/usr/var/run/dbus # criar a pasta que o dbus funcionará
		rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid #remover o pid para que o dbus-daemon funcione corretamente
		rm -rf system_bus_socket

		dbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket #cria o arquivo

		if grep -q "<listen>tcp:host=localhost" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<listen>unix:tmpdir=/tmp</listen>" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<auth>ANONYMOUS</auth>" /data/data/com.termux/files/usr/share/dbus-1/system.conf && # verifica se existe a linha com esse texto
		grep -q "<allow_anonymous/>" /data/data/com.termux/files/usr/share/dbus-1/system.conf; then # verifica se existe a linha com esse texto
		echo ""
			else
				sed -i 's|<auth>EXTERNAL</auth>|<listen>tcp:host=localhost,bind=*,port=6667,family=ipv4</listen>\
				<listen>unix:tmpdir=/tmp</listen>\
				<auth>EXTERNAL</auth>\
				<auth>ANONYMOUS</auth>\
				<allow_anonymous/>|' /data/data/com.termux/files/usr/share/dbus-1/system.conf
		fi

		# É necessário repetir o processo toda vez que alterar o system.conf
		rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid
		dbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket
		sed -i "\|command+=\" -b $folder/root:/dev/shm\"|a command+=\" -b system_bus_socket:/run/dbus/system_bus_socket\"" $bin
		sed -i '1 a\rm -rf /data/data/com.termux/files/usr/var/run/dbus/pid \ndbus-daemon --fork --config-file=/data/data/com.termux/files/usr/share/dbus-1/system.conf --address=unix:path=system_bus_socket\n' $bin
	;;
esac
clear

chmod +x $folder/root/config-environment.sh

sleep 4
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin
echo '#!/bin/bash
source "/usr/local/bin/global_var_fun.sh"
groupadd -g 3003 group3003
groupadd -g 9997 group9997
groupadd -g 20457 group20457
groupadd -g 50457 group50457
groupadd -g 1079 group1079

echo "${label_alert_autoupdate_for_u}"

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

total_steps=5
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt

clear
chmod +x /usr/local/bin/vnc
chmod +x /usr/local/bin/vncpasswd
chmod +x /usr/local/bin/startvnc
chmod +x /usr/local/bin/stopvnc
chmod +x /usr/local/bin/startvncserver

bash ~/locale_${system_icu_locale_code}.sh

apt update -y > /dev/null 2>&1

bash ~/system-config.sh

clear

bash ~/config-environment.sh

if [ ! -e "~/start-environment.sh" ];then
	bash ~/start-environment.sh
fi

show_progress_dialog check-packages "Verificando todos os pacotes globais instalados..." \
	sudo xz-utils firefox code bleachbit at-spi2-core gvfs-backends synaptic evince font-manager \
	nautilus inetutils-tools nano dbus-x11 tigervnc-tools tigervnc-common tigervnc-standalone-server \
	exo-utils apt-utils python3-gi python3 tar zip unzip curl gpg git dialog wget locales language-pack-pt-base \
	keyboard-configuration tzdata 

rm -rf ~/locale*.sh
rm -rf ~/.bash_profile
rm -rf ~/.hushlogin' > $folder/root/.bash_profile 

# Cria uma gui de inicialização
sed -i '\|command+=" /bin/bash --login"|a command+=" -b /usr/local/bin/startvncserver"' $bin
cp "$bin" "$PREFIX/bin/andistro_files/${bin%.sh}" #isso permite que o comando seja iniciado sem o uso do bash ou ./
rm -rf $HOME/distrolinux-install.sh
rm -rf $HOME/start-distro.sh
bash $bin