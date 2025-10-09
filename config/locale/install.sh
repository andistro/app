#!/bin/bash

if [ -f "$PREFIX/var/lib/andistro/lib/share/global" ]; then
    chmod +x "$PREFIX/var/lib/andistro/lib/share/global"
    source "$PREFIX/var/lib/andistro/lib/share/global"
    mkdir -p "$PREFIX/var/lib/andistro/lib/share/locales/"
    path="$PREFIX/var/lib/andistro/lib/share/locales/"
elif [ -f "/usr/local/bin/global" ]; then
    chmod +x "/usr/local/bin/global"
    source "/usr/local/bin/global"
    mkdir -p "/usr/local/bin/locales"
    path="$folder/usr/local/bin/locales"
else
    echo "Erro: arquivo global de configuração não encontrado."
fi

show_progress_dialog "wget" "${label_language_download}" 1 \
    -P "$path" "${extralink}/config/package-manager-setups/apt/locale/locale_en-US.sh" \
    -P "$path" "${extralink}/config/package-manager-setups/apt/locale/locale_pt-BR.sh"
