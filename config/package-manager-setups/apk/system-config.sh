#!/bin/bash

# Verifica se o arquivo global_var_fun.sh existe antes de fazer source
if [ -f "/usr/local/bin/global_var_fun.sh" ]; then
    source "/usr/local/bin/global_var_fun.sh"
elif [ -f "$PREFIX/bin/global_var_fun.sh" ]; then
    source "$PREFIX/bin/global_var_fun.sh"
else
    echo "Erro: Arquivo global_var_fun.sh não encontrado!"
    echo "Procurado em:"
    echo "  /usr/local/bin/global_var_fun.sh"
    echo "  $PREFIX/bin/global_var_fun.sh"
    exit 1
fi

# Verifica se as variáveis de localização estão definidas
if [ -z "$system_icu_locale_code" ]; then
    # Fallback para definir o locale se não estiver definido
    if [ -n "$LANG" ]; then
        system_icu_locale_code=$(echo "$LANG" | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')
    else
        system_icu_locale_code="en-us"
    fi
fi

# Define variáveis de fallback se não estiverem definidas
label_find_update="${label_find_update:-Atualizando lista de pacotes...}"
label_upgrade="${label_upgrade:-Atualizando sistema...}"
label_tzdata_settings="${label_tzdata_settings:-Configurando timezone...}"
label_install_script_download="${label_install_script_download:-Instalando}"
label_system_setup="${label_system_setup:-Configurando sistema...}"
label_done="${label_done:-Concluído!}"
title_progress="${title_progress:-Progresso}"

# Verifica se o comando dialog está disponível
if ! command -v dialog >/dev/null 2>&1; then
    echo "Erro: O comando 'dialog' não está disponível no sistema."
    echo "Instale o dialog primeiro:"
    echo "  Alpine: sudo apk add dialog"
    echo "  Debian/Ubuntu: sudo apt install dialog"
    exit 1
fi

# Verifica se estamos no Alpine Linux
if ! command -v apk >/dev/null 2>&1; then
    echo "Erro: Este script é específico para Alpine Linux (comando 'apk' não encontrado)."
    exit 1
fi

# Cria o diretório de logs se não existir
mkdir -p "/sdcard/termux/andistro/logs" 2>/dev/null || {
    # Se não conseguir criar em /sdcard, tenta em $HOME
    mkdir -p "$HOME/andistro/logs"
    echo "Aviso: Usando $HOME/andistro/logs para logs (não foi possível criar em /sdcard)"
}

# Função melhorada para verificar se um pacote está instalado no Alpine
check_apk_package() {
    local package="$1"
    apk info -e "$package" >/dev/null 2>&1
}

# Função para instalar pacote se não estiver instalado
install_if_missing() {
    local package="$1"
    if ! check_apk_package "$package"; then
        echo "Instalando $package..."
        sudo apk add --no-cache "$package"
    else
        echo "$package já está instalado."
    fi
}

# Lista de pacotes essenciais para verificar/instalar
essential_packages=(
    "ca-certificates"
    "wget"
    "curl"
    "dialog"
    "bash"
)

# Verifica e instala pacotes essenciais primeiro
echo "Verificando pacotes essenciais..."
for pkg in "${essential_packages[@]}"; do
    install_if_missing "$pkg"
done

# Executa o script principal com tratamento de erros
echo "Iniciando configuração do sistema Alpine..."

show_progress_dialog steps-multi-label 22 \
  "${label_find_update}" 'sudo apk update' \
  "${label_upgrade}" 'sudo apk upgrade' \
  "${label_tzdata_settings}" 'sudo apk add --no-cache tzdata' \
  "${label_install_script_download}\\nca-certificates" 'sudo apk add --no-cache ca-certificates' \
  "${label_install_script_download}\\nwget" 'sudo apk add --no-cache wget' \
  "${label_install_script_download}\\ncurl" 'sudo apk add --no-cache curl' \
  "${label_install_script_download}\\ngpg" 'sudo apk add --no-cache gpg' \
  "${label_install_script_download}\\ngit" 'sudo apk add --no-cache git' \
  "${label_install_script_download}\\nopenssl" 'sudo apk add --no-cache openssl' \
  "${label_install_script_download}\\npython3" 'sudo apk add --no-cache python3' \
  "${label_install_script_download}\\ntar" 'sudo apk add --no-cache tar' \
  "${label_install_script_download}\\nunzip" 'sudo apk add --no-cache unzip' \
  "${label_install_script_download}\\nzip" 'sudo apk add --no-cache zip' \
  "${label_install_script_download}\\ntigervnc" 'sudo apk add --no-cache tigervnc' \
  "${label_install_script_download}\\ndbus-x11" 'sudo apk add --no-cache dbus-x11' \
  "${label_install_script_download}\\nnano" 'sudo apk add --no-cache nano' \
  "${label_install_script_download}\\nnautilus" 'sudo apk add --no-cache nautilus' \
  "${label_install_script_download}\\nfont-manager" 'sudo apk add --no-cache font-manager' \
  "${label_install_script_download}\\nevince" 'sudo apk add --no-cache evince' \
  "${label_install_script_download}\\nfirefox" 'sudo apk add --no-cache firefox' \
  "${label_system_setup}" 'if [ ! -d "$HOME/.config/gtk-3.0" ]; then mkdir -p "$HOME/.config/gtk-3.0"; echo "Pasta .config/gtk-3.0 criada"; fi' \
  "${label_system_setup}" 'echo -e "file:/// raiz\\nfile:///sdcard sdcard" > "$HOME/.config/gtk-3.0/bookmarks" && echo "Bookmarks do GTK configurados"'

# Verifica se houve erro na execução
if [ $? -ne 0 ]; then
    echo "Erro durante a execução do script de configuração."
    echo "Verifique os logs em /sdcard/termux/andistro/logs/ ou $HOME/andistro/logs/"
    exit 1
fi

echo "Configuração do sistema Alpine concluída com sucesso!"
sleep 2