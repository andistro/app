#!/data/data/com.termux/files/usr/bin/bash

# Variáveis de configuração
config_file="$PREFIX/var/lib/andistro/boot/.config/debian-based"
export distro_name="ubuntu"
codinome="noble"
andistro_files="$PREFIX/var/lib/andistro"
bin="$PREFIX/var/lib/andistro/boot/start-$distro_name"
folder="$PREFIX/var/lib/andistro/boot/$distro_name/$codinome"
binds="$PREFIX/var/lib/andistro/boot/$distro_name/binds"
storage_root="$HOME/storage/shared/termux/andistro/boot/$distro_name/$codinome"

# Fonte modular configuração global
source "$PREFIX/var/lib/andistro/lib/share/global"

# Verificar e criar diretórios necessários
if [ ! -d "$PREFIX/var/lib/andistro/boot/$distro_name" ];then
    mkdir -p "$PREFIX/var/lib/andistro/boot/$distro_name"
fi

if [ ! -d "$HOME/storage/shared/termux/andistro/boot/$distro_name/$codinome" ];then
    mkdir -p "$HOME/storage/shared/termux/"
    mkdir -p "$HOME/storage/shared/termux/andistro"
    mkdir -p "$HOME/storage/shared/termux/andistro/boot"
    mkdir -p "$HOME/storage/shared/termux/andistro/boot/$distro_name/$codinome"
fi

mkdir -p $binds

# Verificar se o idioma do sistema está no mapa, senão usar en-US
if [[ -n "${LANG_CODES[$system_icu_locale_code]}" ]]; then
    system_lang_code="$system_icu_locale_code"
else
    system_lang_code="en-US"
fi

# Montar opções do menu
OPTIONS=()
OPTIONS+=("auto" "→ ${LANG_CODES[$system_lang_code]} $label_detected")
OPTIONS+=("SEP" "────────────")  # Separador visual seguro

# Adicionar os demais idiomas em ordem alfabética (exceto o detectado)
for code in $(printf "%s\n" "${!LANG_CODES[@]}" | sort); do
    [[ "$code" == "$system_lang_code" ]] && continue
    OPTIONS+=("$code" "${LANG_CODES[$code]}")
done

# Tamanho da janela do dialog
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=10

# Mostrar menu com redirecionamento seguro
exec 3>&1
CHOICE=$(dialog --no-shadow --clear \
    --title "$MENU_language_select" \
    --menu "$MENU_language_select" \
    $HEIGHT $WIDTH $CHOICE_HEIGHT \
    "${OPTIONS[@]}" \
    2>&1 1>&3)
exec 3>&-


# Determinar idioma selecionado
if [[ "$CHOICE" == "auto" || -z "$CHOICE" ]]; then
    language_selected="$system_lang_code"
elif [[ "$CHOICE" == "SEP" ]]; then
    exit 0  # ignorar separador
else
    language_selected="$CHOICE"
fi

# Converter de pt-BR para pt_BR
language_transformed="${language_selected//-/_}"

# Exportar, se necessário
export language_selected
export language_transformed

#=============================================================================================
# Caso a versão já tenha sido baixada, não baixar novamente
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

	show_progress_dialog wget "${label_distro_download}" -O $folder.tar.xz "https://github.com/andistro/app/releases/download/${distro_name}_${codinome}/installer-${archurl}.tar.xz"
	sleep 2
	# Extrai a imagem do sistema
	show_progress_dialog extract "${label_distro_download_extract}" "$folder.tar.xz"
	sleep 2
	rm -rf $folder.tar.xz # remove o arquivo
fi

mkdir -p "${folder}/proc/fakethings"

if [ ! -f "${folder}/proc/fakethings/stat" ]; then
	cat <<- EOF > "${folder}/proc/fakethings/stat"
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

if [ ! -f "${folder}/proc/fakethings/vmstat" ]; then
	cat <<- EOF > "${folder}/proc/fakethings/vmstat"
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
if [ ! -d "\$HOME/storage" ];then
    termux-setup-storage
fi

#cd \$(dirname \$0)
cd \$HOME

pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
pacmd load-module module-aaudio-sink

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
command+=" -b /dev/null:/proc/sys/kernel/cap_last_cap"
command+=" -b /proc"
command+=" -b \$TMPDIR:/tmp"
command+=" -b /proc/meminfo:/proc/meminfo"
command+=" -b /sys"
command+=" -b /data"
command+=" -b $folder/root:/dev/shm"
## Exclusivo Ubuntu
command+=" -b /proc/self/fd/2:/dev/stderr"
command+=" -b /proc/self/fd/1:/dev/stdout"
command+=" -b /proc/self/fd/0:/dev/stdin"
command+=" -b /dev/urandom:/dev/random"
command+=" -b /proc/self/fd:/dev/fd"
command+=" -b $folder/proc/fakethings/stat:/proc/stat"
command+=" -b $folder/proc/fakethings/vmstat:/proc/vmstat"
command+=" -b $folder/proc/fakethings/version:/proc/version"
## uncomment the following line to have access to the home directory of termux
command+=" -b /data/data/com.termux/files/home:/termux/home"
command+=" -b /data/data/com.termux/files/usr/var/lib/andistro/lib/share:/usr/local/bin/andistro"
command+=" -b /data/data/com.termux/files/usr/var/lib/andistro/boot:/usr/local/bin/andistro/boot"
command+=" -b /data/data/com.termux/files/usr/var/lib/andistro/boot/.config/debian-based/bin:/usr/local/bin/"
command+=" -b /data/data/com.termux/files/usr/bin/andistro:/usr/local/bin/andistro/bin/andistro"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" MOZ_FAKE_NO_SANDBOX=1"
command+=" HOME=/root"
command+=" DISPLAY=:1"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
#command+=" LANG=C.UTF-8"
command+=" LANG=$language_transformed.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
PA_PID=\$(pgrep pulseaudio)
if [ -n "\$PA_PID" ]; then
  kill \$PA_PID
fi
EOM

chmod +x $bin

# Configurações pós-instalação
# copia o arquivo de configuração de idioma da pasta $PREFIX/var/lib/andistro/boot/.configs/debian-based/locale_setup/ ppara o root
cp $config_file/locale_setup/locale_${language_selected}.sh $folder/root/locale_${language_selected}.sh

cp $config_file/system-config.sh $folder/root/system-config.sh
cp $config_file/wallpapers.sh $folder/root/wallpapers.sh

# Adicionar entradas em hosts, resolv.conf e timezone
echo "127.0.0.1 localhost localhost" | tee $folder/etc/hosts
echo "nameserver 8.8.8.8" | tee $folder/etc/resolv.conf 
echo "$system_timezone" | tee $folder/etc/timezone

# Se não existir, será criado
mkdir -p "$folder/usr/share/backgrounds/"
mkdir -p "$folder/usr/share/icons/"
mkdir -p "$folder/root/.vnc/"
# Escolher o ambiente gráfico
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

OPTIONS=(1 "${MENU_environments_select_default} (XFCE4)"
		 2 "${MENU_environments_select_light} (LXDE)"
		 3 "${MENU_environments_select_null}") 

CHOICE=$(dialog --no-shadow --clear \
                --title "$TITLE" \
                --menu "$MENU_environments_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
	1)	
		# XFCE
		cp "$config_file/environment/xfce4/config-environment.sh" "$folder/root/config-environment.sh"
		cp "$config_file/environment/xfce4/xfce4-panel.tar.bz2" "$folder/root/xfce4-panel.tar.bz2"
		sleep 2
		;;
	2)	
		# LXDE
		cp "$config_file/environment/lxde/config-environment.sh" "$folder/root/config-environment.sh"
		sleep 2
	;;
	3)
		# Nenhum escolhido
		rm -rf "$folder/root/system-config.sh"
		sleep 2
	;;
esac
clear

sleep 4
echo "APT::Acquire::Retries \"3\";" > $folder/etc/apt/apt.conf.d/80-retries #Setting APT retry count
touch $folder/root/.hushlogin

cat > $folder/root/.bash_profile <<- EOM
#!/bin/bash
export LANG=$language_transformed.UTF-8

source "/usr/local/bin/andistro/global"

groupadd -g 3003 group3003
groupadd -g 9997 group9997
groupadd -g 20457 group20457
groupadd -g 50457 group50457
groupadd -g 1079 group1079

# Mensagem de inicialização
echo -e "\n ${distro_wait}\n"
#======================================================================================================
# global == update_progress() {}
update_progress() {
    local current_step=\$1
    local total_steps=\$2
    local percent=\$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=\$((percent * bar_length / 100))
    local empty_length=\$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=\$(printf "%\${filled_length}s" | tr " " "=")
    empty_bar=\$(printf "%\${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "\$filled_bar" "\$empty_bar" "\$percent" > /dev/tty
}

total_steps=5
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "\$current_step" "\$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt install sudo --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando sudo"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt install wget --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt install dialog --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando dialog"
sleep 0.5

if ! dpkg -l | grep -qw nano; then
    apt install nano --no-install-recommends -y > /dev/null 2>&1
fi
((current_step++))
update_progress "\$current_step" "\$total_steps" "Instalando nano"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
#======================================================================================================
sudo dpkg --configure -a > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1

etc_timezone=\$(cat /etc/timezone)

sudo ln -sf "/usr/share/zoneinfo/\$etc_timezone" /etc/localtime

# Executa as configurações de idioma
bash ~/locale_$language_selected.sh

# Baixa os wallpapers adicionais
bash ~/wallpapers.sh

# Seletor de tema
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

OPTIONS=(1 "\${MENU_theme_select_light}"
		 2 "\${MENU_theme_select_dark}")

CHOICE=\$(dialog --no-shadow --clear \
                --title "\$TITLE" \
                --menu "\$MENU_theme_select" \
                \$HEIGHT \$WIDTH \$CHOICE_HEIGHT \
                "\${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case \$CHOICE in
	1)	
		echo "Light Theme"
		export distro_theme="Light"
	;;
	2)	
		echo "Dark Theme"
		export distro_theme="Dark"
	;;
esac

# Executa as configurações base do sistema
export distro_id="$distro_name"
bash ~/system-config.sh "\$distro_theme" "\$distro_id"

# Configurações da inteface escolhida
bash ~/config-environment.sh "\$distro_theme"

rm -rf ~/locale*.sh
rm -rf ~/.hushlogin
rm -rf ~/system-config.sh
rm -rf ~/config-environment.sh
rm -rf ~/start-environment.sh
rm -rf ~/wallpapers.sh
rm -rf ~/app-list-recommends.sh
rm -rf ~/.bash_profile
exit
EOM

# Inicia o sistema
bash $bin