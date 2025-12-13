#!/bin/bash
# Troca o nome "Brazil" por "Brasil"
if [ "$system_country" = "Brazil" ]; then
    system_country="Brasil"
fi

#=====================================================================================================
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Específicos do executável andistro

# Global andistro
distro_desc_line_1="Use: andistro <comando> <opção> para seja feito a tarefa desejada."
distro_desc_line_10="Comandos disponíveis para você:"

# Exclusivo andistro no termux
distro_desc_line_2="Exemplo de comando que permite a inicialização:"
distro_desc_line_3="   andistro -s debian"
distro_desc_line_4="Exemplo de comando que permite a desinstalação:"
distro_desc_line_5="   andistro -d debian"
distro_desc_line_6="Exemplo de comando que permite a instalação:"
distro_desc_line_7="   andistro -i debian"
distro_desc_line_8="Exemplo de comando que permite a atualização do AnDistro:"
distro_desc_line_9="   andistro -u"
    
distro_desc_line_11="    -s  inicializa a versão escolhida."
distro_desc_line_12="    -d  desinstala a opção escolhida."
distro_desc_line_13="    -i  instala a opção escolhida."
distro_desc_line_14="    -u  atualiza o AnDistro."

distro_desc_line_15="Opções de sistemas disponíveis para instalação:"
distro_desc_line_16="Opções de sistemas disponíveis para inicialização e desinstalação:"


# Exclusivo andistro distros
distro_desc_line_17="    --boot  comando para iniciar alguma configuração."
distro_desc_line_18="Subcomandos do --boot"
distro_desc_line_19="    vnc  para iniciar o servidor VNC"
distro_desc_line_20="Subcomandos do --boot vnc"
distro_desc_line_21="    --display  define a resolução da tela que será exibida"
distro_desc_line_22="    --scale    define a escala da tela (1 ou 2)"
distro_desc_line_23="    --port     define a porta usada pelo servidor."
distro_desc_line_24="Exemplo de comando que permite a inicialização do servior vnc"
distro_desc_line_25="Modo simples"
distro_desc_line_26="   andistro --boot vnc"
distro_desc_line_27="Modo completo"
distro_desc_line_28="   andistro --boot vnc --display 1920x1080 --port 1 --scale 1"
distro_desc_line_29="O comando --scale só funciona no xfce4, caso use no lxde, o comando será ignorado"
distro_desc_line_30="O comando --display e --port não são obrigatórios e caso não use o servidor será iniciado na resolução e porta padrão."

distro_desc_line_31="Modo de instalação sem interface gráfica, totalmente terminal"
distro_desc_line_32="Adicione o -sh após o nome da distribuição"
distro_desc_line_33="Exemplo de comando que permite a instalação sem interface gráfica"
distro_desc_line_34="   andistro -i debian-sh"

distro_command_not_found="Comando não encontrado:"

distro_instaled="instalado"
distro_install="instalar"
distro_notinstaled="não instalado"
distro_option="<opção>"
distro_start="iniciar"
distro_update="atualizar"
distro_wait="aguarde"
distro_del="desinstalar"
distro_command="<comando>"

label_system_start="Iniciar o sistema"
label_system_uninstall="Desinstalar o sistema"
label_system_install_systems="Instalar sistemas"
label_system_install_other_systems="Instalar outros sistemas"
label_andistro_updater="Atualizar o AnDistro"
label_andistro_termianl_viewer="Ver como terminal"
label_andistro_there_no_system_installed="Não tem nenhum sistema instalado"
label_all_systems_have_been_installed="Todos os sistemas foram instalados"

#//////////////////////////////////////////////////////////////////////////////////////////////////////
#=====================================================================================================

#=====================================================================================================
# Aguardos
label_progress="Em andamento..."
label_upgrade="Atualizando o sistema..."
label_wait="Aguarde"

# Baixar
label_distro_download="Baixando o %s..."
label_distro_download_finish="A ultima versão do %s foi baixada com sucesso."
label_distro_download_start="Em breve será baixado a ultima versão do %s para o armazenamento..."
label_install_script_download="Baixando script de instalação..."
label_skip_download="Pulando o download"
label_update_finish="Atualização concluída!"
label_wallpaper_download="Baixando papéis de parede..."

# Configurações
label_keyboard_setup="Iniciando as configurações do teclado, aguarde...."
label_keyboard_active_sugest="Caso necessário toque no botão para abrir o teclado (⌨)"
label_system_setup="Configurando o sistema..."
label_xdg_user_dirs_setup="Configurando as pastas padrões para o sistema..."

# Fuso horário
label_system_timezone="Fuso horário"
label_distro_alert_timezone_desc="O fuso horário será o mesmo do dispositivo."
label_distro_alert_timezone_detected="Fuso horário detectado: "

# Alertas
label_uninstall_success="Desinstalação concluida!"
label_install_success="Instalação concluida!"
label_setup_apply="Configuração aplicada!"

# Senhas
label_change_password="A senha foi alterada com sucesso. "

label_password_forgot="Esqueceu a senha? Use o comando 'andistro --setup senha' para redefinir a senha."
label_password_input="Digite a nova senha para o servidor VNC"
label_password_input_alert_important="É necessário definir uma senha!"
label_password_save_failed="Falha ao salvar a senha!"

# Escolhas
label_choose_one_of_the_option="Escolha uma das opções"
label_choose_language="Escolha o idioma "
label_choose_theme="Escolha um tema"

#Indisponibilidade
label_command_not_available="Este comando não está disponível para o sistema atual."

#Erros e recusas
label_entry_canceled="Entrada cancelada pelo usuário."
label_command_problem_andistro_for_distro="Este comando só funciona se encerrar o sistema."

# Dica
label_info_command_andistro_start="Use o comando 'andistro' para iniciar."
label_select_no_to_choose_other_resolution="Selecione 'Não' para escolher outra resolução."
label_start_dialog_display="Caso queira iniciar o servidor com a tela interativa, use o comando:\nandistro --boot vnc --dialog-display"

# Informativos em palavra única
label_error="Erro"
label_done="Finalizado"
label_width="Largura"
label_height="Altura"
label_scale="Escala"
label_port="Porta"
label_localhost="Local:"
label_confirm="Confirmar"
label_cancel="Cancelar"
label_themes="Temas"
label_icons="Ícones"
label_light="Claro"
label_dark="Escuro"
label_resolution="Resolução"
label_landscape="Paisagem"
label_portrait="Retrato"
label_user="Usuário"
label_password="Senha"
label_password_alt_min="senha"
label_back="Voltar"
label_next="Próximo"

# Informativos em colchetes
label_detected="[Detectado]"
label_numbers_only="[SOMENTE NÚMEROS]"

# Interface
label_config_environment_gui="Configurando a interface..."
label_install_environment_gui="Baixando as configurações para a interface funcionar..."
label_environments_select="Escolha uma interface de área de trabalho: "
label_environments_select_default="Padrão"
label_environments_select_light="Leve"
label_environments_select_null="Nenhum"

# Procura
label_file_not_found="Arquivo de localização não encontrado"
label_find_update="Procurando atualizações..."
label_system_found="Sistema identificado!"
label_system_not_found="Sistema não identificado!"

# Temporizador
label_sleep_in_10s="Esta mensagem desaparecerá em 10 segundos."

# Sistema
label_distro_boot="O sistema %s foi iniciado"
label_distro_not_installed="O %s não está instalado."
label_distro_not_installed_desc="O %s ainda não foi instalado, siga os passos abaixo para a instalação:\nDigite o comando 'andistro' seguido do enter , escolha a opção instalar. Depois escolha o %s para iniciar a instalação."
label_distro_installed="O %s já está instalado."

# Servidor
label_server_kill_desc="Desligando o servidor..."
label_server_kill_desced="Desligando o servidor da porta"
label_server_kill_desc_error="Nenhum servidor VNC encontrado para o usuário $USER"
label_server_setup="Configuração do servidor"
label_server_start_desc="O servidor foi iniciado."
label_server_start_error="O servidor VNC não está iniciado. Por favor, registro de erros em .vnc/localhost.log."
label_select_resolution="Seleção de resolução"
label_choose_one_resolution="Escolha uma das opções abaixo"

label_resolution_frequent="Resolução Frequente Detectada"
label_resolution_frequent_desc="Você tem usado a resolução %s na ultimas vezes.\n\nDeseja definir esta resolução como padrão?\n\nIsso evitará que o menu de seleção apareça nas próximas vezes."
label_resolution_remove_default="Deseja remover a resolução padrão?"
label_resolution_remove_default_desc="Você está prestes a remover a resolução padrão salva.\n\nIsso fará com que o menu de seleção de resolução apareça novamente na próxima vez que iniciar o VNC.\n\nDeseja continuar?"
label_resolution_remove_default_sucess="A resolução deixou de ser a padrão."

label_resolution_option_default="Resolução padrão"
label_resolution_option_default_desc="Ao confirmar, irá usar a resolução definida como padrão."
label_resolution_choose_options="Escolha algumas opções"
label_resolution_choose_default="Você escolheu usar a resolução padrão"
label_resolution_choose_custom="Você escolheu definir a resolução manualmente"
label_resolution_choose_custom_desc="Insira a resolução personalizada no formato LARGURAxALTURA. Exemplo: 1920x1200"
label_resolution_choose_custom_desc_port="Defina um número para a porta ou mantenha a que está definida como padrão.  A porta padrão é 1."
label_resolution_choose_custom_desc_scale="Defina um número para a escala ou mantenha a que está definida como padrão.  A escala padrão é 1."
label_resolution_choose_custom_desc_alert="Houve algum erro nos dados inseridos. Será retornado a tela anterior. Leia atentamente a descrição e repita o procedimeto."

label_resolution_option_custom="Defina a resolução manualmente"
label_resolution_option_uwhd="Ultrawide HD"
label_resolution_option_qdhd="Quad-HD"
label_resolution_option_fhd="Full-HD"
label_resolution_option_fhd_wide="Full-HD estendido"
label_resolution_option_hd="HD"

label_dialog_display_menu_sugestion="Sugestões de Resolução"
label_dialog_display_menu_sugestion_desc="Deseja que toda vez que o sistema seja iniciado, apareça uma caixa de diálogo com sugestões de resolução de tela?"