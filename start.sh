#!/data/data/com.termux/files/usr/bin/bash
#🚀
termux-setup-storage
# Gerar os logs de registro
#mkdir ~/storage/shared/termux_logs
#exec 1>> ~/storage/shared/termux_logs/install_process.log 2>&1


apt install wget curl proot tar dialog whiptail -y > /dev/null 2>&1 &
clear

#~/.termux/termux.properties
# enforce-char-based-input = true
#termux-reload-settings #caso o arquivo não exista, será criado
#sed -i 's/# enforce-char-based-input = true/enforce-char-based-input = true/' ~/.termux/termux.properties
#sed -i 's/# hide-soft-keyboard-on-startup = true/hide-soft-keyboard-on-startup = true/' ~/.termux/termux.properties
# soft-keyboard-toggle-behaviour = enable/disable
# Uncomment to not show soft keyboard on application starrt
#termux-reload-settings

# Vai pedir o acesso a memória do celular
#Logs do sistema
extralink="https://raw.githubusercontent.com/andistro/app/main"
system_icu_locale_code=$(getprop persist.sys.locale)

if [ -f "fixed_variables.sh" ]; then
	source fixed_variables.sh
	else

  (
				echo 0  # Inicia em 0%
				wget --tries=20 "${extralink}/config/fixed_variables.sh" --progress=dot:giga 2>&1 | while read -r line; do
					# Extraindo a porcentagem do progresso do wget
					if [[ $line =~ ([0-9]+)% ]]; then
						percent=${BASH_REMATCH[1]}
						echo $percent  # Atualiza a barra de progresso
					fi
				done

				echo 50  # Finaliza em 50%
			) | dialog --gauge " " 5 40 0

		chmod +x fixed_variables.sh
		source fixed_variables.sh
fi

if [ -f "l10n_${system_icu_locale_code}.sh" ]; then
	source l10n_$system_icu_locale_code.sh
	else


    (
				echo 51  # Inicia em 51%
				wget --tries=20 "${extralink}/config/locale/l10n_${system_icu_locale_code}.sh" --progress=dot:giga 2>&1 | while read -r line; do
					# Extraindo a porcentagem do progresso do wget
					if [[ $line =~ ([0-9]+)% ]]; then
						percent=${BASH_REMATCH[1]}
						echo $percent  # Atualiza a barra de progresso
					fi
				done

				echo 100  # Finaliza em 100%
			) | dialog --gauge " " 5 40 0
		chmod +x l10n_$system_icu_locale_code.sh
    source l10n_$system_icu_locale_code.sh
fi


if [ -f "$PREFIX/bin/$distro_del" ]; then
	echo "existe"
	else
  (
				echo 0  # Inicia em 0%
				wget --tries=20 "${extralink}/desinstalar" --progress=dot:giga 2>&1 | while read -r line; do
					# Extraindo a porcentagem do progresso do wget
					if [[ $line =~ ([0-9]+)% ]]; then
						percent=${BASH_REMATCH[1]}
						echo $percent  # Atualiza a barra de progresso
					fi
				done

				echo 50  # Finaliza em 50%
			) | dialog --gauge " " 5 40 0

		chmod +x $distro_del
    mv $distro_del "$PREFIX/bin/"
fi

wget --tries=20 "${extralink}/sys-info" -O sys-info > /dev/null 2>&1 &
chmod +x sys-info

# Exibir a caixa de progresso
(
  progress=0
  while [ $progress -lt $steps ]; do
    sleep $whiptail_intervalo
    echo "${label_progress}"
    echo "$((++progress * 100 / steps))"
  done
  echo "${label_progress}"
  echo "100"
  sleep 2
  clear
) | dialog --gauge "${system_info}" 6 40 0

# Limpar a tela
clear

OPTIONS=(1 "Ubuntu"
         2  "Debian")

CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --menu "$MENU_operating_system_select" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
1)
  echo "Ubuntu"
  wget --tries=20 "${extralink}/distros/ubuntu.sh" -O start-distro.sh > /dev/null 2>&1 &

  (
    while pkill -0 wget >/dev/null 2>&1; do
      sleep $whiptail_intervalo
      
      echo "${label_progress}"
      
      echo "$((++percentage))"
    done

    echo "${label_progress}"

    echo "75"
    sleep 2
  ) | dialog --gauge "${label_progress}" 6 40 0

  clear
;;
2)
  echo "Debian [Teste]"
  wget --tries=20 "${extralink}/distros/debian.sh" -O start-distro.sh > /dev/null 2>&1 &

  (
    while pkill -0 wget >/dev/null 2>&1; do
      sleep $whiptail_intervalo
      
      echo "${label_progress}"
      
      echo "$((++percentage))"
    done

    echo "${label_progress}"

    echo "75"
    sleep 2
  ) | dialog --gauge "${label_progress}" 6 40 0

  clear
;;

esac

chmod +x start-distro.sh
bash start-distro.sh