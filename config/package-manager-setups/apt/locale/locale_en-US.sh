#!/bin/bash
# Mudar o idioma para o Inglês dos Estados Unidos [en_US]
source "/usr/local/bin/global"

error_code="LG002en"
show_progress_dialog steps-one-label "${label_system_language}" 10 \
    "apt update" \
    "apt install locales -y" \
    "apt install language-pack-en-base -y" \
    "sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen" \
    "locale-gen" \
    "echo 'LANG=en_US.UTF-8' > /etc/locale.conf" \
    "echo 'export LC_ALL=en_US.UTF-8' >> ~/.bashrc" \
    "echo 'export LANG=en_US.UTF-8' >> ~/.bashrc" \
    "echo 'export LANGUAGE=en_US.UTF-8' >> ~/.bashrc" \
    "apt update"

sleep 2

rm -rf locale_en-US.sh
