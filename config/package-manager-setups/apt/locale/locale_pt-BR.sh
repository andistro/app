#!/bin/bash
# Mudar o idioma para o Portuguê Brasileiro [pt_BR]
source "/usr/local/bin/global_var_fun.sh"

error_code="LG002br"
show_progress_dialog steps-one-label "${label_system_language}" 8 \
    "apt update" \
    "apt install locales -y" \
    "apt install language-pack-pt-base -y" \
    "sed -i 's/^# *\(pt_BR.UTF-8\)/\1/' /etc/locale.gen" \
    "locale-gen" \
    "echo 'export LC_ALL=pt_BR.UTF-8' >> ~/.bashrc" \
    "echo 'export LANG=pt_BR.UTF-8' >> ~/.bashrc" \
    "echo 'export LANGUAGE=pt_BR.UTF-8' >> ~/.bashrc" \
    "apt update"

sleep 2
## Exportar os comandos de configuração de idioma para ~/.bashrc
## Essa configuração necessita de reboot
#sed -i '\|export LANG|a LANG=pt_BR.UTF-8|' ~/.vnc/xstartup\

rm -rf locale_pt-BR.sh
