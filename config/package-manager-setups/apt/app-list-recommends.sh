#!/bin/bash
source "/usr/local/bin/global"
# Define os programas para seleção
PROGS=(
    "brave-browser"   "Brave Browser"      off
    "inkscape"  "Inkscape" off
    "libreoffice"  "LibreOffice" off
)

# Mostra o checklist e coleta seleção
CHOICES=$(dialog --separate-output \
    --checklist "Selecione os programas para instalar:" 10 50 7 \
    "${PROGS[@]}" \
    2>&1 >/dev/tty)

# Conta etapas selecionadas
NUM_ETAPAS=$(echo "$CHOICES" | wc -l)

# Monta comandos de instalação para cada selecionado
COMANDOS=()
for escolha in $CHOICES; do
    COMANDOS+=("sudo apt install $escolha --no-install-recommends -y")
done

# Executa o show_progress_dialog somente se houve seleção
if [ "$NUM_ETAPAS" -gt 0 ]; then
    show_progress_dialog steps-one-label "Instalando pacotes selecionados" "$NUM_ETAPAS" "${COMANDOS[@]}"
else
    dialog --msgbox "Nenhum pacote selecionado." 8 40
fi
