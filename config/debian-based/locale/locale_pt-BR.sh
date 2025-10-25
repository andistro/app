#!/bin/bash
# Mudar o idioma para o Português Brasileiro [pt_BR]

source "/usr/local/bin/andistro/global"

error_code="LG002br"
show_progress_dialog steps-one-label "${label_system_language}" 10 \
    "apt update" \
    "apt install locales -y" \
    "apt install language-pack-pt-base -y" \
    "sed -i 's/^# *\(pt_BR.UTF-8\)/\1/' /etc/locale.gen" \
    "locale-gen" \
    "echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf" \
    "echo 'export LC_ALL=pt_BR.UTF-8' >> ~/.bashrc" \
    "echo 'export LANG=pt_BR.UTF-8' >> ~/.bashrc" \
    "echo 'export LANGUAGE=pt_BR.UTF-8' >> ~/.bashrc" \
    "apt update"

sleep 2

rm -rf locale_pt-BR.sh
