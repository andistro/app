#!/bin/bash
source "$PREFIX/var/lib/andistro/lib/share/global"
mkdir -p "$PREFIX/var/lib/andistro/lib/share/locales/"
path="$PREFIX/var/lib/andistro/lib/share/locales"

update_progress() {
    current_step=$1
    total_steps=$2

    percent=$((current_step * 100 / total_steps))
    bar_length=30
    filled_length=$((percent * bar_length / 100))
    empty_length=$((bar_length - filled_length))

    filled_bar=$(printf "%${filled_length}s" | tr " " "=")
    empty_bar=$(printf "%${empty_length}s" | tr " " " ")

    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" 
}

total_steps=3  # Número total de etapas que você quer monitorar
current_step=0

{
    sleep 1
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1

    #2 English US
    l10n="en-US"
    if [ ! -f "$path/l10n_$l10n.sh" ]; then
        wget -P "$path" "${extralink}/config/locale/l10n_$l10n.sh" > /dev/null 2>&1
        else
        wget -O "$path/l10n_$l10n.check" "${extralink}/config/locale/l10n_$l10n.sh" > /dev/null 2>&1

        if [ -f "$path/l10n_$l10n.sh" ] && [ -f "$path/l10n_$l10n.check" ]; then
            if ! cmp -s "$path/l10n_$l10n.sh" "$path/l10n_$l10n.check"; then
                rm "$path/l10n_$l10n.sh"
                mv "$path/l10n_$l10n.check" "$path/l10n_$l10n.sh"
                chmod +x "$path/l10n_$l10n.sh"
            else
                rm "$path/l10n_$l10n.check"
            fi
        fi
    fi
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1

    #3 Portuguese BR
    l10n="pt-BR"
    if [ ! -f "$path/l10n_$l10n.sh" ]; then
        wget -P "$path" "${extralink}/config/locale/l10n_$l10n.sh" > /dev/null 2>&1
        else
        wget -O "$path/l10n_$l10n.check" "${extralink}/config/locale/l10n_$l10n.sh" > /dev/null 2>&1

        if [ -f "$path/l10n_$l10n.sh" ] && [ -f "$path/l10n_$l10n.check" ]; then
            if ! cmp -s "$path/l10n_$l10n.sh" "$path/l10n_$l10n.check"; then
                rm "$path/l10n_$l10n.sh"
                mv "$path/l10n_$l10n.check" "$path/l10n_$l10n.sh"
                chmod +x "$path/l10n_$l10n.sh"
            else
                rm "$path/l10n_$l10n.check"
            fi
        fi
    fi
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1

    echo
}

chmod +x $path/l10n_*.sh