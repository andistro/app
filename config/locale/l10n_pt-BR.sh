#!/bin/bash
# Troca o nome "Brazil" por "Brasil"
if [ "$system_country" = "Brazil" ]; then
  system_country="Brasil"
fi

#=====================================================================================================










label_detected="[Detectado]"
label_distro_alert_timezone_desc="O Fuso horário será o mesmo do dispositivo."
label_distro_alert_timezone_detected="Fuso horário detectado: "
label_sleep_in_5s="Esta mensagem desaparecerá em 5 segundos."
label_sleep_in_10s="Esta mensagem desaparecerá em 10 segundos."
label_keyboard_setup="Iniciando as configurações do teclado, $distro_wait...."
label_tzdata_setup="Iniciando as configurações de fuso horário e data, $distro_wait...."

#=====================================================================================================
# Andistro
distro_command="<comando>"
distro_command_not_found="Comando não encontrado:"
distro_del="desinstalar"
distro_desc_line_1="Use: andistro <comando> <opção> para seja feito a tarefa desejada."
distro_desc_line_2="Exemplo de comando que permite a instalação:"
distro_desc_line_3="   andistro -i debian"
distro_desc_line_4="Exemplo de comando que permite a desinstalação:"
distro_desc_line_5="   andistro -d debian"
distro_desc_line_6="Exemplo de comando que permite a inicialização:"
distro_desc_line_7="   andistro -s debian"
distro_desc_line_8="Comandos:"
distro_desc_line_9="    -u  atualiza todos os pacotes."
distro_desc_line_10="    -i  instala a opção escolhida."
distro_desc_line_11="    -d  desinstala a opção escolhida."
distro_desc_line_12="    -s  inicializa a versão escolhida."
distro_desc_line_13="Opções:"
distro_instaled="instalado"
distro_install="instalar"
distro_notinstaled="não instalado"
distro_option="<opção>"
distro_start="iniciar"
distro_update="atualizar"
distro_wait="aguarde"
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
label_install_environment_gui="Baixando as configurações para a interface funcionar..."
label_start_script="Escrevendo script de inicialização"
label_entry_canceled="Entrada cancelada pelo usuário."
label_sucess="Sucesso!"
label_completed="Concluído"
label_done="Finalizado"
label_change_password="A senha do VNC foi alterada com sucesso. "
label_retry="Tentando novamente..."
label_error="Erro"
label_vnc_password_save_failed="Falha ao salvar a senha!"
label_numbers_only="[SOMENTE NÚMEROS]"
label_width="Largura"
label_height="Altura"
label_scale="Escala"
label_port="Porta"
label_localhost="Local:"
label_confirm="Confirmar"
label_cancel="Cancelar"
label_themes="Temas"
label_icons="Ícones"
label_resolution_default="Resolução $current_resolution definida como padrão!"
label_update_finish="Atualização concluída! \nUse o comando 'andistro' para iniciar."
label_system_icu_locale_code_file_error="Arquivo de localização não encontrado:"
label_installing="Instalando"
label_setting_up="Configurando"
label_resoluciondefault="definida como padrão!"

#VNC
label_vnc_setup="Configuração do VNC"

# VNC Passwd
label_vnc_password_input="Digite a nova senha para o servidor VNC: "
label_vnc_password_input_alert="Toque no botão para abrir o teclado (⌨). Caso não faça isso, a próxima etapa terá erro. Depois pressione OK."
label_vnc_password_input_alert_important="É necessário definir uma senha!"
label_vncserver_password_forgot="Esqueceu a senha? Use o comando 'vncpasswd' para redefinir a senha do VNC."


label_startvnc_desc="O servidor VNC foi iniciado. A senha padrão é a senha da conta "
label_vncserver_kill="Desligando o servidor VNC..."
label_vncserver_kill_port="Digite o número da porta que deseja fechar (exemplo: 1): "
label_vncserver_killed="Desligando o VNC da porta"
label_vncserver_kill_error="Nenhum servidor VNC encontrado para o usuário $USER"
label_vncserver_resolution_title="Seleção de resolução"
label_vncserver_resolution_option="Escolha uma das opções abaixo:"
label_vncserver_resolution_option_horizontal="Iniciar o vncserver na resolução Horizontal"
label_vncserver_resolution_option_vertical="Iniciar o vncserver na resolução Vertical"
label_vncserver_resolution_option_uwhd="Iniciar o vncserver na resolução Ultrawide HD"
label_vncserver_resolution_option_qdhd="Iniciar o vncserver na resolução Quad-HD"
label_vncserver_resolution_option_qdhdplus="Iniciar o vncserver na resolução Quad-HD Plus"
label_vncserver_resolution_option_fhd="Iniciar o vncserver na resolução Full-HD"
label_vncserver_resolution_option_fhdplus="Iniciar o vncserver na resolução Full-HD Plus"
label_vncserver_resolution_option_hd="Iniciar o vncserver na resolução HD"
label_vncserver_resolution_option_hdplus="Iniciar o vncserver na resolução HD Plus"
label_vncserver_resolution_option_custom="Definir resolução, porta e escala manualmente"
label_vncserver_resolution_option_predefined="Escolha a partir de uma lista pré-definida"
label_vncserver_resolution_default="Resolução padrão"
label_vncserver_resolution_default_desc="Ao confirmar, irá usar definida como padrão: \n\n Resolução: $RESOLUTION \nPorta: ${PORT:-1}, \nEscala: ${SCALE:-1})\n\nSelecione 'Não' para escolher outra resolução."
label_vncserver_resolution_frequent_desc_title="Resolução Frequente Detectada"
label_vncserver_resolution_frequent_desc="Você tem usado a resolução %s frequentemente.\n\nDeseja definir esta resolução como padrão?\n\nIsso evitará que o menu de seleção apareça nas próximas vezes."
label_vncserver_chose_resolution_uwhd="Você escolheu a resolução Ultra Wide HD"
label_vncserver_chose_resolution_qdhd="Você escolheu a resolução Quad-HD"
label_vncserver_chose_resolution_fhd="Você escolheu a resolução Full HD"
label_vncserver_chose_resolution_hd="Você escolheu a resolução HD"
label_vncserver_chose_resolution_default="Você escolheu usar a resolução padrão"
label_vncserver_chose_resolution_custom="Você escolheu definir a resolução e porta manualmente"
label_vncserver_chose_resolution_custom_desc="Insira a resolução personalizada no formato LARGURAxALTURA. Exemplo: 1920x1200"
label_vncserver_chose_resolution_custom_desc_port="Insira o número da porta. Exemplo: 2. A porta padrão é 1"
label_vncserver_chose_resolution_custom_alert="Atenção: Não tecle ENTER (↲) antes de preencher todos os campos. Clique no texto para selecionar e poder digitar."
label_vncserver_chose_resolution_custom_alert_caption="Legenda: o campo em azul é o que está selecionado para digitar. Use as teclas ↑ e ↓ para trocar a seleção. Pode clicar nos nomes para selecionar."
label_vncserver_chose_resolution_custom_alert_error="Faltam ou há valores inválidos nos campos abaixo:\n"
label_vncserver_chose_resolution_canceled="Cancelado. Use o comando startvnc para selecionar outra resolução"

label_vncserver_remove_default_title="Deseja remover a resolução padrão?"
#label_vncserver_remove_default_desc="Deseja remover a resolução padrão?"
label_vncserver_remove_default_desc="Você está prestes a remover a resolução padrão salva.\n\nIsso fará com que o menu de seleção de resolução apareça novamente na próxima vez que iniciar o VNC.\n\nDeseja continuar?"
label_vncserver_remove_default_sucess="Resolução padrão removida com sucesso."


# Sobre downloads
label_install_script_download="Baixando script de instalação..."
label_install_script_download_check="Confirmando a instalação..."
label_skip_download="Pulando o download"
label_decopressing_rootfs="Descompactando arquivos..."
label_wallpaper_download="Baixando wallpaper..."
label_gnome_download_setup="Baixando as configurações necessárias para o Gnome..."

#Download do sistema
label_distro_download="Baixando o $distro_name..."
label_distro_download_extract="Extraindo o $distro_name para o armazenamento..."

label_ubuntu_download="Baixando o Ubuntu..."
label_ubuntu_download_extract="Extraindo o Ubuntu para o armazenamento..."

label_debian_download_start="Preparando para baixar a ultima versão do Debian... \nIsso pode levar alguns minutos, $distro_wait..."
label_debian_download="Baixando a ultima versão do Debian..."
label_debian_download_finish="A ultima versão do Debian foi baixada com sucesso."
label_debian_download_extract="Extraindo o Debian para o armazenamento..."

#TITULO DO MENU DE DIALOGO
MENU_operating_system_select="Escolha o sistema operacional que será instalado: "
MENU_language_select="Escolha o idioma "
MENU_language_selected="Idioma selecionado: "
MENU_environments_select="Escolha um ambientes de área de trabalho: "
MENU_environments_select_default="Padrão"
MENU_environments_select_light="Leve"
MENU_environments_select_null="Nenhum"

# Seletor de temas
MENU_theme_select="Escolha um tema: "
MENU_theme_select_light="Claro"
MENU_theme_select_dark="Escuro"

# Lista de recomendações

label_apps_select_install="Selecione apps o sistema \nVeja abaixo alguns apps selecionados para você começar. \n\nClique naqueles que deseja instalar e tecle enter (↲) ou clique em <Aceitar>. \n\nCaso não queira nenhum dos listados, mantenha sem selecionar, tecle enter (↲) ou clique em aceitar para pular esta etapa. \n\n\nA tecla enter (↲) não tem função de seleção, somente de confirmação."