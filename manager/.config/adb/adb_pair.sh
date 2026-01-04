#!/data/data/com.termux/files/usr/bin/bash
wlan_ip_localhost=$(ifconfig 2>/dev/null | grep 'inet ' | grep broadcast | awk '{print $2}') # IP da rede
mkdir -p /tmp
termux-toast "AnDistro: Verificando Termux:API..."
status=$?

if [ $status -eq 0 ]; then
    # O Termux:API está instalado e respondendo
    #echo "[OK] termux-toast executou com sucesso (Termux:API está instalado e respondendo)."
    {
        for i in {1..50}; do
            sleep 0.1
            echo $((i * 2))
        done
    } | dialog --no-shadow --gauge "É necessário cuidado para essa configuração. Siga atentamente ao que for solicitado e caso necessário, poderá solicitar ajuda nos foruns do Termux ou na wiki do AnDistro\n\n$label_sleep_in_10s" $dialog_height $dialog_width
    clear

    andistro --setup device-info-settings

    dialog --no-shadow --title "Permitir acesso ADB ao Termux" \
    --backtitle "$label_warning" \
    --yes-label "$label_open" \
    --no-label "$label_close" \
    --yesno "ATENÇÃO: LEIA TUDO. \n\nClique em < Abrir > para que seja aberto as configurações de desenvolvedor do seu dispositivo e procure pela opção chamada 'Depuração por Wi-FI', ative e dentro da opção, clique em parear dispositivo com código de pareamento e assim que o código for gerado, SEM APERTAR NO BOTÃO DE VOLTAR OU DE INÍCIO, abra as notificações do celular e digite o código na notificação do Termux sobre o código de pareamento. Logo após clique em enviar" \
    25 $dialog_width
    dialog_retorno=$?

    if [ $dialog_retorno -eq 0 ]; then 
        am start -a android.settings.APPLICATION_DEVELOPMENT_SETTINGS
        sleep 2

        # Notificação 1: Solicitar código da porta
        wlan_ip_localhost=$(ifconfig 2>/dev/null | grep 'inet ' | grep broadcast | awk '{print $2}') # IP da rede
        notify_adb_port_code(){
            termux-notification \
                --title "Digite o código da porta" \
                --content "O código que aparece logo após o $wlan_ip_localhost:_____" \
                --button1 "Digite o código" \
                --button1-action 'echo "adbPortCode=\"$REPLY\"" >> "$HOME/.adb_setup.sh"; andistro --setup notify-adb-pair-code;'
        }

        # Notificação 2: Digitar código de pareamento
        notify_adb_pair_code(){
            termux-notification \
                --title "Digite o código de pareamento" \
                --content "Código de 6 digitos em destaque, ao lado ou abaixo da descrição \"Código de pareamento por Wi-Fi\"" \
                --button1 "Digite o código" \
                --button1-action 'echo "adbPairCode=\"$REPLY\"" >> "$HOME/.adb_setup.sh"; andistro --setup adb-pair;'
        }
        

        adb_pair(){
            
        }

        
    fi

else
    # O Termux:API não está instalado ou não está respondendo
    {
        for i in {1..50}; do
            sleep 0.1
            echo $((i * 2))
        done
    } | dialog --no-shadow --gauge "Para que essa ferramenta funcione perfeitamente, será necessário instalar o Termux:API. Link nas configurações do AnDistro\n\n$label_sleep_in_10s" $dialog_height $dialog_width
    clear
fi