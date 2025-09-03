#!/bin/bash
export extralink="https://raw.githubusercontent.com/andistro/app/main"
export NEWT_COLORS="window=,white border=black,white title=black,white textbox=black,white button=white,blue"

# detector de gerenciadores de pacotes
# Detecta o gerenciador de pacotes do sistema e executa comandos específicos
for cmd in apt apk pacman dnf zypper; do
    if command -v $cmd >/dev/null 2>&1; then
        #echo "Detectado: $cmd"
        pkg_cmd="$cmd"
    fi
done

detect_package_manager() {
    if command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v apk >/dev/null 2>&1; then
        echo "apk"
    else
        echo "unknown"
    fi
}


exit_erro() { # ao usar esse comando, o sistema encerra caso haja erro
  if [ $? -ne 0 ]; then
    echo "Erro na execução. Abortando instalação. Código ${error_code}"
    exit 1
  fi
}


#Formato GMT
GMT_date=$(date +"%Z":00)


# VERIFICADOR DO GETPROP ==================================================================================
# Verifica se o comando getprop existe antes de executar
if command -v getprop > /dev/null 2>&1; then
    android_version=$(getprop ro.build.version.release 2>/dev/null)         # Versão do Android
    android_architecture=$(getprop ro.product.cpu.abi 2>/dev/null)         # Arquitetura do aparelho
    device_manufacturer=$(getprop ro.product.manufacturer 2>/dev/null)     # Fabricante
    device_model=$(getprop ro.product.model 2>/dev/null)                   # Modelo
    device_model_complete=$(getprop ril.product_code 2>/dev/null)          # Código do modelo

    device_hardware=$(getprop ro.hardware.chipname 2>/dev/null)            # Chipset Processador
    system_country=$(getprop ro.csc.country_code 2>/dev/null)              # País
    system_country_iso=$(getprop ro.csc.countryiso_code 2>/dev/null)       # Abreviação do País
    system_icu_locale_code=$(getprop persist.sys.locale 2>/dev/null)       # Locale
    system_timezone=$(getprop persist.sys.timezone 2>/dev/null)            # Timezone
else
    system_icu_locale_code=$(echo $LANG | sed 's/\..*//' | sed 's/_/-/')
    system_architecture=$(dpkg --print-architecture)
fi

wlan_ip_localhost=$(ifconfig 2>/dev/null | grep 'inet ' | grep broadcast | awk '{print $2}') # IP da rede 


# PACOTE DE IDIOMAS ==================================================================================
# Irá carregar os pacotes de idiomas que tiver no sistema
if [ -f "$PREFIX/bin/andistro_files/l10n_${system_icu_locale_code}.sh" ]; then
    echo "Solicitando a fonte $PREFIX/bin/andistro_files/l10n_${system_icu_locale_code}.sh"
    clear
    chmod +x "$PREFIX/bin/andistro_files/l10n_${system_icu_locale_code}.sh"
    source "$PREFIX/bin/andistro_files/l10n_${system_icu_locale_code}.sh"
elif [ -f "/usr/local/bin/l10n_${system_icu_locale_code}.sh" ]; then
    echo "Solicitando a fonte /usr/local/bin/l10n_${system_icu_locale_code}.sh"
    clear
    chmod +x "/usr/local/bin/l10n_${system_icu_locale_code}.sh"
    source "/usr/local/bin/l10n_${system_icu_locale_code}.sh"
else
    echo "Arquivo de localização não encontrado para o código: $system_icu_locale_code"
fi

# Variáveis de idioma
# Define o idioma do sistema baseado no arquivo de localização carregado
declare -A LANG_CODES
LANG_CODES["pt-BR"]="Português do Brasil (pt-BR)"
LANG_CODES["en-US"]="English (en-US)"


# TERMINAL Progress  ==================================================================================
# A barra de progresso aparece no terminal sem caixa de dialogo
# Função para atualizar a barra de progresso
# update_progress() precisa ser definido antes de ser usado

# Sistema de identificação pacotes instalados ==================================================================================

check_packages_installed() {
    local missing=()
    for pkg in "$@"; do
        if dpkg -s "$pkg" &> /dev/null; then
            echo "[✓] $pkg está instalado."
        else
            echo "[✗] $pkg NÃO está instalado."
            missing+=("$pkg")
        fi
    done

    # Retorno útil se quiser tomar decisões baseadas nos pacotes ausentes
    if [ ${#missing[@]} -gt 0 ]; then
        echo "Pacotes ausentes: ${missing[*]}"
        return 1
    else
        return 0
    fi
}
# Use o check_packages_installed curl wget git
# Exemplo de verificador e download
#if ! check_packages_installed curl wget git; then
#    echo "Instalando pacotes ausentes..."
#    sudo apt install -y curl wget git
#fi

# //////////////////////////////////////////////////////////////////////////////////////////////////
# ==================================================================================================
# update_progress() ===========================================================================================
# ==================================================================================================
# //////////////////////////////////////////////////////////////////////////////////////////////////
update_progress() {
    local current_step=$1
    local total_steps=$2
    local percent=$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=$((percent * bar_length / 100))
    local empty_length=$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=$(printf "%${filled_length}s" | tr " " "=")
    empty_bar=$(printf "%${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

# total_steps=2  # Número total de etapas que você quer monitorar
# current_step=0


# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# ==================================================================================================
# DIALOG ===========================================================================================
# ==================================================================================================
# //////////////////////////////////////////////////////////////////////////////////////////////////

# DIALOG menu ==================================================================================
export USER=$(whoami)
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1


# DIALOG Progress ==================================================================================
# Função para ter uma barra de progresso usando o dialog em diversas tarefas
show_progress_dialog() {
    # show_progress_dialog [type] [title] [steps/count/pid] [commands...]
    # Types supported:
    #   steps         - Multiple labeled commands
    #   apt-labeled   - apt/apt-get with labels
    #   wget          - Simple download
    #   wget-labeled  - Multiple labeled downloads
    #   pid           - Background process (long-running)
    #   extract       - Extract .zip, .tar, .tar.gz, .xz
    local mode="$1"
    shift

    case "$mode" in
        steps-one-label)
            # Ex: show_progress_dialog steps-one "${label_etapa}" total_comandos \
            #     'comando1' 'comando2' 'comando3'
            local label="$1"
            local total="$2"
            shift 2

            {
                local count=0
                local percent=0
                for cmd in "$@"; do
                    echo "XXX"
                    percent=$(( count * 100 / total ))
                    echo "$percent"
                    echo "$label"
                    echo "XXX"
                    bash -c "$cmd" &>/dev/null
                    count=$((count + 1))
                done

                echo "XXX"
                echo "100"
                echo "${label_completed}"
                echo "XXX"
                sleep 1  # <–– aqui o label final aparece por pelo menos 1s
            } | dialog --gauge "$label" 10 70 0
        ;;

        steps-multi-label)
            # Ex: show_progress_dialog steps 2 \
            #     "${label_step1}" 'comando1' \
            #     "${label_step2}" 'comando2'

            local steps="$1"
            local timestamp=$(date +'%d%m%Y-%H%M%S')
            shift
            {
                local percent step=0
                while [ "$#" -gt 1 ]; do
                    local lbl="$1"
                    local cmd="$2"
                    echo "XXX"
                    percent=$(( step * 100 / steps ))
                    echo "$percent"
                    echo "$lbl"
                    echo "XXX"
                    bash -c "$cmd"  >> "/sdcard/termux/andistro/logs/steps-multi-label_${timestamp}.txt" 2>&1
                    step=$((step + 1))
                    shift 2
                done
                echo "XXX"
                echo "100"
                echo "${label_completed}"
                echo "XXX"
                sleep 1  # <–– aqui o label final aparece por pelo menos 1s
            } | dialog --gauge "$title_progress" 10 70 0
        ;;

        wget)
            # Ex: show_progress_dialog wget "${label}" -O arquivo URL
            # Ex: show_progress_dialog wget "${label_download}" \
            #     -O "$HOME/arquivo.tar.xz" "${url_do_arquivo}"

            local label="$1"
            shift
            {
                wget "$@" &>/dev/null &
                local pid=$!
                local percent=0
                while kill -0 "$pid" 2>/dev/null; do
                    echo "XXX"
                    echo "$percent"
                    echo "$label"
                    echo "XXX"
                    percent=$(( percent < 95 ? percent + 1 : 95 ))
                    sleep 0.3
                done
                echo "XXX"
                echo "100"
                echo "${label_completed}"
                echo "XXX"
            } | dialog --gauge "$label" 10 70 0
        ;;

        wget-labeled)
            local label="$1"
            local total="$2"
            shift 2

            {
                local count=0

                while [ $# -gt 0 ]; do
                    local current_label="$1"
                    shift
                    local wget_opts=()
                    while [[ $# -gt 1 && "$1" == -* ]]; do
                        wget_opts+=("$1")
                        shift
                        wget_opts+=("$1")
                        shift
                    done
                    local url="$1"
                    shift

                    echo -e "XXX\n$((count * 100 / total))\n${current_label}\nXXX"

                    wget --tries=20 --progress=bar:force:noscroll "${wget_opts[@]}" "$url" 2>&1 |
                    stdbuf -oL grep --line-buffered "%" |
                    stdbuf -oL sed -u -e "s,\.,,g" | awk -v count="$count" -v total="$total" -v label="$current_label" '
                        {
                            match($0, /([0-9]{1,3})%/, arr);
                            if (arr[1] != "") {
                                percent = int((count * 100 + arr[1]) / total);
                                print "XXX\n" percent "\n" label "\nXXX";
                            }
                        }'

                    ((count++))
                done

                echo -e "XXX\n100\n${label_completed}\nXXX"
                echo -e "XXX\n100\nXXX"
            } | dialog --gauge "$label" 10 70 0
        ;;
        
        extract)
            local label="$1"
            local file="$2"
            local dest="$3"

            # Se não passar destino, cria pasta com o mesmo nome do arquivo (sem extensão)
            if [ -z "$dest" ]; then
                case "$file" in
                    *.tar.xz) dest="$(dirname "$file")/$(basename "$file" .tar.xz)" ;;
                    *.tar.gz) dest="$(dirname "$file")/$(basename "$file" .tar.gz)" ;;
                    *.tgz)    dest="$(dirname "$file")/$(basename "$file" .tgz)" ;;
                    *.tar.bz2) dest="$(dirname "$file")/$(basename "$file" .tar.bz2)" ;;
                    *.tar)    dest="$(dirname "$file")/$(basename "$file" .tar)" ;;
                    *.zip)    dest="$(dirname "$file")/$(basename "$file" .zip)" ;;
                    *)        dest="$(dirname "$file")" ;; # fallback
                esac
            fi

            # Verifica se o arquivo existe
            if [ ! -f "$file" ]; then
                dialog --title "Erro" --msgbox "Arquivo não encontrado: $file" 10 50
                return 1
            fi

            mkdir -p "$dest"

            case "$file" in
                *.tar.xz) cmd=(tar -xJf "$file" -C "$dest") ;;
                *.tar.gz|*.tgz) cmd=(tar -xzf "$file" -C "$dest") ;;
                *.tar.bz2) cmd=(tar -xjf "$file" -C "$dest") ;;
                *.tar) cmd=(tar -xf "$file" -C "$dest") ;;
                *.zip) cmd=(unzip -o "$file" -d "$dest") ;;
                *.xz) cmd=(xz -d "$file") ;;
                *.gz) cmd=(gunzip "$file") ;;
                *)
                    dialog --title "Erro" --msgbox "Formato de arquivo não suportado: $file" 10 50
                    return 1
                ;;
            esac

            set +m
            (
                "${cmd[@]}" >/dev/null 2>&1
            ) & disown
            pid=$!

            {
                i=0
                while kill -0 "$pid" 2>/dev/null; do
                    echo $i
                    sleep 0.2
                    i=$((i + 2))
                    [ $i -ge 95 ] && i=95
                done
                echo 100
                set -m
            } | dialog --gauge "$label" 10 70 0
        ;;


        check-packages)
            # Exemplo de uso:
            # show_progress_dialog check-packages "Verificando" pacote1 pacote2 ...

            local title="$1"
            shift
            local packages=("$@")
            local total="${#packages[@]}"
            local timestamp=$(date +'%d%m%Y-%H%M%S')
            local log_file="/sdcard/termux/andistro/logs/check_packages_${timestamp}.txt"
            local pkg_manager=$(detect_package_manager)
            : > "$log_file"

            {
                for i in "${!packages[@]}"; do
                    local pkg="${packages[$i]}"
                    local index=$(printf "%02d" $((i + 1)))

                    case "$pkg_manager" in
                        apt)
                            if dpkg -s "$pkg" &>/dev/null; then
                                echo "$index [✓] $pkg está instalado." >> "$log_file"
                            else
                                echo "$index [✗] $pkg NÃO está instalado." >> "$log_file"
                            fi
                            ;;
                        apk)
                            if apk info -e "$pkg" &>/dev/null; then
                                echo "$index [✓] $pkg está instalado." >> "$log_file"
                            else
                                echo "$index [✗] $pkg NÃO está instalado." >> "$log_file"
                            fi
                            ;;
                        *)
                            echo "$index [?] Não foi possível verificar $pkg (gerenciador desconhecido)." >> "$log_file"
                            ;;
                    esac

                    # Atualiza porcentagem de progresso
                    percent=$(( (i + 1) * 100 / total ))
                    echo "$percent"
                    sleep 0.2
                done
            } | dialog --title "$title" --gauge "Verificando pacotes..." 10 60 0

            # Exibe resultado final com scroll, sem botão OK
            dialog --title "Resultado da verificação" --textbox "$log_file" 25 80
            ;;

        *)
            echo "Modo desconhecido para show_progress_dialog: $mode" >&2
            return 1
        ;;
    esac
}
