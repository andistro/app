#!/bin/bash
source "$PREFIX/var/lib/andistro/lib/share/global"    
mkdir -p "$PREFIX/var/lib/andistro/lib/share/locales/"
path="$PREFIX/var/lib/andistro/lib/share/locales"

show_progress_dialog "wget" "${label_language_download}" 1 \
    -P "$path" "${extralink}/config/locale/l10n_en-US.sh" \
    -P "$path" "${extralink}/config/locale/l10n_pt-BR.sh"

chmod +x "$path/l10n_*.sh"