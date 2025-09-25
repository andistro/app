#!/bin/bash
source "/usr/local/bin/global"
PROGS=(
 "brave-browser" "Brave Browser" off
 "figma-linux" "Figma Linux" off
 "inkscape" "Inkscape" off
 "libreoffice" "LibreOffice" off
)
CHOICES=$(dialog --no-shadow --separate-output \
 --checklist "Selecione os programas para instalar:" 10 50 7 \
 "${PROGS[@]}" \
 2>&1 >/dev/tty)

# Conta etapas
NUM_ETAPAS=0
ETAPAS=()
timestamp=$(date +%Y%m%d-%H%M%S)

for chr in $CHOICES; do
 case "$chr" in
 "figma-linux")
   log_file="/sdcard/termux/andistro/logs/app-recommends-figma-linux_${timestamp}.txt"
   ETAPAS+=(
     "Instalando dependência libgconf-2-4" "sudo apt install libgconf-2-4 --no-install-recommends -y >> $log_file 2>&1"
     "Baixando Figma-Linux (.deb)" "wget -O /tmp/figma-linux.deb https://github.com/Figma-Linux/figma-linux/releases/download/v0.11.5/figma-linux_0.11.5_linux_arm64.deb >> $log_file 2>&1"
     "Instalando Figma-Linux" "sudo dpkg -i /tmp/figma-linux.deb ; sudo apt install -f -y >> $log_file 2>&1"
     "Ajustando atalho Figma" "sudo sed -i 's|Exec=/usr/share/figma-linux/figma-linux|Exec=/usr/share/figma-linux/figma-linux --no-sandbox|' /usr/share/applications/figma-linux.desktop >> $log_file 2>&1"
   )
   NUM_ETAPAS=$((NUM_ETAPAS + 4))
  ;;
 "brave-browser")
   log_file="/sdcard/termux/andistro/logs/app-recommends-brave-browser_${timestamp}.txt"
   ETAPAS+=(
     "Instalando Brave Browser" "sudo apt install brave-browser --no-install-recommends -y >> $log_file 2>&1"
     "Ajustando atalho Brave" "sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/brave-browser.desktop >> $log_file 2>&1"
     "Ajustando atalho Brave 2" "sudo sed -i 's|Exec=/usr/bin/brave-browser-stable|Exec=/usr/bin/brave-browser-stable --no-sandbox|' /usr/share/applications/com.brave.Browser.desktop >> $log_file 2>&1"
   )
   NUM_ETAPAS=$((NUM_ETAPAS + 3))
  ;;
 *)
   log_file="/sdcard/termux/andistro/logs/app-recommends-${chr}_${timestamp}.txt"
   ETAPAS+=(
     "Instalando $chr" "sudo apt install $chr --no-install-recommends -y >> $log_file 2>&1"
   )
   NUM_ETAPAS=$((NUM_ETAPAS + 1))
  ;;
 esac
done
if [ "$NUM_ETAPAS" -gt 0 ]; then
 show_progress_dialog steps-multi-label "$NUM_ETAPAS" "${ETAPAS[@]}"
else
 dialog --msgbox "Nenhum pacote selecionado." 8 40
fi
