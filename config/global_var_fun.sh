#!/bin/bash
export extralink="https://raw.githubusercontent.com/andistro/app/alpha"
export NEWT_COLORS="window=,white border=black,white title=black,white textbox=black,white button=white,blue"

# Detector de gerenciadores de pacotes melhorado
detect_package_manager() {
    if command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v apk >/dev/null 2>&1; then
        echo "apk"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v zypper >/dev/null 2>&1; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Variável global para o gerenciador de pacotes detectado
pkg_cmd=$(detect_package_manager)
export pkg_cmd

# Função para sair em caso de erro
exit_erro() {
    local error_code=${1:-$?}
    if [ $error_code -ne 0 ]; then
        echo "Erro na execução. Abortando instalação. Código ${error_code}"
        exit $error_code
    fi
}

# Formato GMT
GMT_date=$(date +"%Z":00)

# VERIFICADOR DO GETPROP ==================================================================================
# Verifica se o comando getprop existe antes de executar
if command -v getprop > /dev/null 2>&1; then
    # Ambiente Android/Termux
    android_version=$(getprop ro.build.version.release 2>/dev/null)
    android_architecture=$(getprop ro.product.cpu.abi 2>/dev/null)
    device_manufacturer=$(getprop ro.product.manufacturer 2>/dev/null)
    device_model=$(getprop ro.product.model 2>/dev/null)
    device_model_complete=$(getprop ril.product_code 2>/dev/null)
    device_hardware=$(getprop ro.hardware.chipname 2>/dev/null)
    system_country=$(getprop ro.csc.country_code 2>/dev/null)
    system_country_iso=$(getprop ro.csc.countryiso_code 2>/dev/null)
    system_icu_locale_code=$(getprop persist.sys.locale 2>/dev/null)
    system_timezone=$(getprop persist.sys.timezone 2>/dev/null)
    
    # Fallbacks se getprop falhar
    [ -z "$system_icu_locale_code" ] && system_icu_locale_code=$(echo $LANG | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')
    
    # Detecção de arquitetura para Android
    if command -v dpkg >/dev/null 2>&1; then
        system_architecture=$(dpkg --print-architecture 2>/dev/null)
    else
        system_architecture="$android_architecture"
    fi
else
    # Ambiente Linux tradicional
    system_icu_locale_code=$(echo $LANG | sed 's/\..*//' | sed 's/_/-/' | tr '[:upper:]' '[:lower:]')
    
    # Detecção de arquitetura
    if command -v dpkg >/dev/null 2>&1; then
        system_architecture=$(dpkg --print-architecture 2>/dev/null)
    elif command -v uname >/dev/null 2>&1; then
        arch_raw=$(uname -m)
        case "$arch_raw" in
            x86_64) system_architecture="amd64" ;;
            aarch64) system_architecture="arm64" ;;
            armv7l) system_architecture="armhf" ;;
            i386|i686) system_architecture="i386" ;;
            *) system_architecture="$arch_raw" ;;
        esac
    fi
    
    # Valores padrão para ambiente não-Android
    android_version="N/A"
    android_architecture="$system_architecture"
    device_manufacturer="Unknown"
    device_model="Linux System"
    device_model_complete="N/A"
    device_hardware="Unknown"
    system_country="BR"
    system_country_iso="BR"
    system_timezone=$(timedatectl show --property=Timezone --value 2>/dev/null || echo "America/Sao_Paulo")
fi

# Fallback para locale se ainda estiver vazio
[ -z "$system_icu_locale_code" ] && system_icu_locale_code="pt-br"

# Detecção de IP local
wlan_ip_localhost=$(ip route get 1 2>/dev/null | awk '{print $7}' | head -1)
[ -z "$wlan_ip_localhost" ] && wlan_ip_localhost=$(hostname -I 2>/dev/null | awk '{print $1}')
[ -z "$wlan_ip_localhost" ] && wlan_ip_localhost="127.0.0.1"

# PACOTE DE IDIOMAS ==================================================================================
# Carrega os pacotes de idiomas disponíveis
load_language_pack() {
    local lang_code="$1"
    local search_paths=(
        "$PREFIX/bin/andistro_files/l10n_${lang_code}.sh"
        "/usr/local/bin/l10n_${lang_code}.sh"
        "$HOME/.local/bin/l10n_${lang_code}.sh"
        "./l10n_${lang_code}.sh"
    )
    
    for lang_file in "${search_paths[@]}"; do
        if [ -f "$lang_file" ]; then
            echo "Carregando arquivo de idioma: $lang_file"
            chmod +x "$lang_file"
            source "$lang_file"
            return 0
        fi
    done
    
    echo "Arquivo de localização não encontrado para: $lang_code"
    echo "Usando valores padrão em inglês"
    
    # Valores padrão em inglês
    export label_find_update="Updating package list..."
    export label_upgrade="Upgrading system..."
    export label_tzdata_settings="Setting up timezone..."
    export label_install_script_download="Installing"
    export label_system_setup="Setting up system..."
    export label_done="Done!"
    export title_progress="Progress"
    
    return 1
}

# Carrega o pacote de idiomas
load_language_pack "$system_icu_locale_code"

# Sistema de identificação de pacotes instalados universal ==================================================================================
check_packages_installed() {
    local missing=()
    local pkg_manager=$(detect_package_manager)
    
    for pkg in "$@"; do
        local installed=false
        
        case "$pkg_manager" in
            apt)
                if dpkg -s "$pkg" &> /dev/null; then
                    installed=true
                fi
                ;;
            apk)
                if apk info -e "$pkg" &> /dev/null; then
                    installed=true
                fi
                ;;
            pacman)
                if pacman -Q "$pkg" &> /dev/null; then
                    installed=true
                fi
                ;;
            dnf)
                if dnf list installed "$pkg" &> /dev/null; then
                    installed=true
                fi
                ;;
            zypper)
                if zypper search -i "$pkg" &> /dev/null; then
                    installed=true
                fi
                ;;
        esac
        
        if [ "$installed" = true ]; then
            echo "[✓] $pkg está instalado."
        else
            echo "[✗] $pkg NÃO está instalado."
            missing+=("$pkg")
        fi
    done

    # Retorna lista de pacotes ausentes
    if [ ${#missing[@]} -gt 0 ]; then
        echo "Pacotes ausentes: ${missing[*]}"
        return 1
    else
        return 0
    fi
}

# DIALOG Progress ==================================================================================
# Para o menu de seleção no dialog
export USER=$(whoami)
HEIGHT=0
WIDTH=100
CHOICE_HEIGHT=5
export PORT=1

# Função melhorada para barras de progresso
show_progress_dialog() {
    local mode="$1"
    shift

    # Verifica se dialog está disponível
    if ! command -v dialog >/dev/null 2>&1; then
        echo "Erro: comando 'dialog' não encontrado. Instalando..."
        case "$(detect_package_manager)" in
            apt) sudo apt install -y dialog ;;
            apk) sudo apk add --no-cache dialog ;;
            pacman) sudo pacman -S --noconfirm dialog ;;
            dnf) sudo dnf install -y dialog ;;
            zypper) sudo zypper install -y dialog ;;
            *) echo "Não foi possível instalar o dialog automaticamente"; return 1 ;;
        esac
    fi

    case "$mode" in
        steps-one-label)
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
                    bash -c "$cmd" &>/dev/null || echo "Erro ao executar: $cmd" >&2
                    count=$((count + 1))
                done

                echo "XXX"
                echo "100"
                echo "${label_done}"
                echo "XXX"
            } | dialog --gauge "$label" 10 70 0
            ;;

        steps-multi-label)
            local steps="$1"
            local timestamp=$(date +'%d%m%Y-%H%M%S')
            local log_dir="/sdcard/termux/andistro/logs"
            
            # Cria diretório de log se não existir
            mkdir -p "$log_dir" 2>/dev/null || {
                log_dir="$HOME/andistro/logs"
                mkdir -p "$log_dir"
            }
            
            local log_file="$log_dir/steps-multi-label_${timestamp}.txt"
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
                    
                    # Executa comando com tratamento de erro
                    echo "=== Executando: $cmd ===" >> "$log_file"
                    if bash -c "$cmd" >> "$log_file" 2>&1; then
                        echo "=== Sucesso: $cmd ===" >> "$log_file"
                    else
                        echo "=== ERRO: $cmd ===" >> "$log_file"
                    fi
                    
                    step=$((step + 1))
                    shift 2
                done
                echo "XXX"
                echo "100"
                echo "${label_done}"
                echo "XXX"
            } | dialog --gauge "${title_progress:-Progress}" 10 70 0
            ;;

        wget)
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
                echo "${label_done}"
                echo "XXX"
            } | dialog --gauge "$label" 10 70 0
            ;;

        check-packages)
            local title="$1"
            shift
            local packages=("$@")
            local total="${#packages[@]}"
            local timestamp=$(date +'%d%m%Y-%H%M%S')
            local log_dir="/sdcard/termux/andistro/logs"
            
            mkdir -p "$log_dir" 2>/dev/null || {
                log_dir="$HOME/andistro/logs"
                mkdir -p "$log_dir"
            }
            
            local log_file="$log_dir/check_packages_${timestamp}.txt"
            local pkg_manager=$(detect_package_manager)
            : > "$log_file"

            {
                for i in "${!packages[@]}"; do
                    local pkg="${packages[$i]}"
                    local index=$(printf "%02d" $((i + 1)))
                    local installed=false

                    case "$pkg_manager" in
                        apt)
                            if dpkg -s "$pkg" &>/dev/null; then
                                installed=true
                            fi
                            ;;
                        apk)
                            if apk info -e "$pkg" &>/dev/null; then
                                installed=true
                            fi
                            ;;
                        pacman)
                            if pacman -Q "$pkg" &>/dev/null; then
                                installed=true
                            fi
                            ;;
                        dnf)
                            if dnf list installed "$pkg" &>/dev/null; then
                                installed=true
                            fi
                            ;;
                        zypper)
                            if zypper search -i "$pkg" &>/dev/null; then
                                installed=true
                            fi
                            ;;
                        *)
                            echo "$index [?] Não foi possível verificar $pkg (gerenciador desconhecido: $pkg_manager)." >> "$log_file"
                            ;;
                    esac

                    if [ "$installed" = true ]; then
                        echo "$index [✓] $pkg está instalado." >> "$log_file"
                    else
                        echo "$index [✗] $pkg NÃO está instalado." >> "$log_file"
                    fi

                    percent=$(( (i + 1) * 100 / total ))
                    echo "$percent"
                    sleep 0.2
                done
            } | dialog --title "$title" --gauge "Verificando pacotes..." 10 60 0

            # Exibe resultado final
            dialog --title "Resultado da verificação" --textbox "$log_file" 25 80
            ;;

        extract)
            local label="$1"
            local file="$2"
            local dest="${3:-.}"

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
                    dialog --title "Erro" --msgbox "Formato não suportado: $file" 10 50
                    return 1
                    ;;
            esac

            {
                "${cmd[@]}" >/dev/null 2>&1 &
                local pid=$!
                local i=0
                while kill -0 "$pid" 2>/dev/null; do
                    echo $i
                    sleep 0.2
                    i=$((i + 2))
                    [ $i -ge 95 ] && i=95
                done
                echo 100
            } | dialog --gauge "$label" 10 70 0
            ;;

        *)
            echo "Modo desconhecido para show_progress_dialog: $mode" >&2
            return 1
            ;;
    esac
}

# Função para mostrar informações do sistema
show_system_info() {
    echo "=== Informações do Sistema ==="
    echo "Gerenciador de pacotes: $pkg_cmd"
    echo "Locale: $system_icu_locale_code"
    echo "Arquitetura: $system_architecture"
    echo "Timezone: $system_timezone"
    echo "IP Local: $wlan_ip_localhost"
    [ -n "$android_version" ] && echo "Android: $android_version"
    [ -n "$device_model" ] && echo "Device: $device_model"
    echo "=========================="
}

# Exporta variáveis importantes
export system_icu_locale_code
export system_architecture
export system_timezone
export wlan_ip_localhost
export pkg_cmd