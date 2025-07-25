#!/bin/bash

if command -v getprop > /dev/null 2>&1; then
    system_country=$(getprop ro.csc.country_code 2>/dev/null)              # País
fi
# Troca o nome "Brazil" por "Brasil"
if [ "$system_country" = "Brazil" ]; then
  system_country="Brasil"
fi

# Se o arquivo ~/.bashrc não existir, cria um vazio
if [ ! -f ~/.bashrc ]; then
  touch ~/.bashrc
fi

# Se existir a linha LANG=pt_BR.UTF-8 dentro de ~/.bashrc
if grep -q "LANG=pt_BR.UTF-8" ~/.bashrc; then
  export LANGUAGE=pt_BR.UTF-8
  export LANG=pt_BR.UTF-8
  export LC_ALL=pt_BR.UTF-8
fi

# Exclui o arquivo ~/.bashrc vazio


#=====================================================================================================
distro_wait="aguarde"
distro_del="desinstalar"
distro_instaled="instalado"
distro_install="instalar"
distro_update="atualizar"
distro_start="iniciar"
distro_notinstaled="não instalado"
distro_command="<comando>"
distro_command_not_found="Comando não encontrado:"
distro_option="<opção>"
distro_desc_line_1="Use: andistro <comando> <opção> para seja feito a tarefa desejada."
distro_desc_line_2="Exemplo de comando que permite a instalação:"
distro_desc_line_3="   andistro instalar debian"
distro_desc_line_4="Exemplo de comando que permite a desinstalação:"
distro_desc_line_5="   andistro desinstalar debian"
distro_desc_line_6="Exemplo de comando que permite a inicialização:"
distro_desc_line_7="   andistro iniciar debian"
distro_desc_line_8="Comandos:"
distro_desc_line_9="    atualizar - atualiza todos os pacotes."
distro_desc_line_10="    instalar - instala a opção escolhida."
distro_desc_line_11="    desinstalar - desinstala a opção escolhida."
distro_desc_line_12="    iniciar - inicializa a versão escolhida."
distro_desc_line_13="Opções:"
label_detected="[Detectado]"
label_distro_alert_timezone_desc="O Fuso horário será o mesmo do dispositivo."
label_distro_alert_timezone_detected="Fuso horário detectado: "
label_sleep_in_5s="Esta mensagem desaparecerá em 5 segundos."
label_sleep_in_10s="Esta mensagem desaparecerá em 10 segundos."
label_keyboard_setup="Iniciando as configurações do teclado, $distro_wait...."
label_tzdata_setup="Iniciando as configurações de fuso horário e data, $distro_wait...."

#=====================================================================================================

label_distro_stable="Estável"
label_distro_previous_version="Versão anterior"

label_system_info="Informações do seu sistema"
label_android_version="Versão do Android"
label_device_manufacturer="Marca"
label_device_model="Modelo"
label_device_hardware="Chipset"
label_android_architecture="Arquitetura"
label_android_architecture_unknow="Arquitetura não identificada"
label_system_country="Região"
label_system_country_iso="Abreviação"
label_system_icu_locale_code="Código do idioma"
label_system_timezone="Fuso horário"
desc_system_info="Use o comando ./sys-info para poder ver essas informações novamente."
label_progress="Em andamento..."
label_language_download="Baixando as configurações do seu idioma..."
label_create_boot="Criando a inicialização..."
label_alert_autoupdate_for_u="Estou me atualizando para que o sistema fique bom para você."
label_find_update="Procurando atualizações..."
label_upgrade="Atualizando o sistema..."
label_install_tools="Instalando ferramentas..."
label_system_setup="Configurando o sistema..."
label_system_language="Configurando idioma..."
label_updating_packages="Aguarde, atualizando pacotes..."
label_keyboard_settings="Trazendo as configurações do teclado...."
label_tzdata_settings="Trazendo as configurações de teclado e fuso horário...."
label_config_environment_gui="Configurando a interface..."
label_install_environment_gui="Baixando as configurações necessárias para a interface funcionar..."
label_start_script="Escrevendo script de inicialização"
label_entry_canceled="Entrada cancelada pelo usuário."
label_sucess="Sucesso!"
label_change_password="A senha do VNC foi alterada com sucesso. "

#VNC
label_vnc_setup="Configuração do VNC"
label_vnc_password_input="Digite a nova senha para o servidor VNC: "
label_startvnc_desc="O servidor VNC foi iniciado. A senha padrão é a senha da conta "
label_vncserver_localhost="Local:"
label_vncserver_password_forgot="Esqueceu a senha? Use o comando 'vncpasswd' para redefinir a senha do VNC."
label_vncserver_kill="Desligando o servidor VNC..."
label_vncserver_kill_port="Digite o número da porta que deseja fechar (exemplo: 1): "
label_vncserver_killed="Desligando o VNC da porta"
label_vncserver_kill_error="Nenhum servidor VNC encontrado para o usuário $USER"
label_vncserver_resolution_title="Seleção de resolução"
label_vncserver_resolution_option="Escolha uma das opções abaixo:"
label_vncserver_resolution_option_uwhd="Iniciar o vncserver na resolução Ultrawide HD"
label_vncserver_resolution_option_qdhd="Iniciar o vncserver na resolução Quad-HD"
label_vncserver_resolution_option_fhd="Iniciar o vncserver na resolução Full-HD"
label_vncserver_resolution_option_hd="Iniciar o vncserver na resolução HD"
label_vncserver_resolution_option_custom="Iniciar o vncserver com resolução e porta customizada"

label_vncserver_chose_resolution_uwhd="Você escolheu a resolução Ultra Wide HD"
label_vncserver_chose_resolution_qdhd="Você escolheu a resolução Quad-HD"
label_vncserver_chose_resolution_fhd="Você escolheu a resolução Full HD"
label_vncserver_chose_resolution_hd="Você escolheu a resolução HD"
label_vncserver_chose_resolution_custom="Você escolheu definir a resolução e porta manualmente"
label_vncserver_chose_resolution_custom_desc="Insira a resolução personalizada no formato LARGURAxALTURA. Exemplo: 1920x1200"
label_vncserver_chose_resolution_custom_desc_port="Insira o número da porta. Exemplo: 2. A porta padrão é 1"

# Sobre downloads
label_install_script_download="Baixando script de instalação..."
label_install_script_download_check="Confirmando a instalação..."
label_skip_download="Pulando o download"
label_decopressing_rootfs="Descompactando arquivos..."
label_wallpaper_download="Baixando wallpaper..."
label_gnome_download_setup="Baixando as configurações necessárias para o Gnome..."

#Download do sistema
label_ubuntu_download="Baixando o Ubuntu..."
label_ubuntu_download_extract="Extraindo o Ubuntu para o armazenamento..."

label_debian_download="Baixando o Debian..."
label_debian_download_extract="Extraindo o Debian para o armazenamento..."

#TITULO DO MENU DE DIALOGO
MENU_operating_system_select="Escolha o sistema operacional que será instalado: "
MENU_language_select="Escolha o idioma "
MENU_language_selected="Idioma selecionado: "
MENU_environments_select="Escolha um ambientes de área de trabalho: "
