#!/bin/bash
# Troca o nome "Brazil" por "Brasil"
if [ "$system_country" = "Brazil" ]; then
    system_country="Brasil"
fi

#=====================================================================================================
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Específicos do executável andistro

# Global andistro
distro_command_guide="Guia de comandos do AnDistro"
distro_desc_line_0="Use: andistro <comando> para seja feito a tarefa desejada."
distro_desc_line_0_0="Use: andistro <comando> <subcomando> para seja feito a tarefa desejada."

## Exclusivo andistro no termux
distro_desc_line_t1="Exemplo de comando que permite a inicialização:"
distro_desc_line_t2="   andistro -s"
distro_desc_line_t3="Exemplo de comando que permite a desinstalação:"
distro_desc_line_t4="   andistro -d"
distro_desc_line_t5="Exemplo de comando que permite a instalação:"
distro_desc_line_t6="   andistro -i"
distro_desc_line_t7="Exemplo de comando que permite a instalação sem interface gráfica"
distro_desc_line_t8="   andistro -i terminal-mode"
distro_desc_line_t9="Exemplo de comando que permite a atualização do AnDistro:"
distro_desc_line_t10="   andistro -u"
distro_desc_line_t11="    -u  atualiza o AnDistro."
distro_desc_line_t12="    -s  inicializa o Debian."
distro_desc_line_t13="    -d  desinstala o Debian."
distro_desc_line_t14="    -i  instala o Debian."

label_andistro_install_system="Instalar o sistema"
label_andistro_start_system="Iniciar o sistema"
label_andistro_termianl_viewer="Ver como terminal"
label_andistro_updater="Atualizar o AnDistro"
label_andistro_uninstall_system="Desinstalar o sistema"
label_andistro_uninstalling_complete="Desinstalação completa do AnDistro!"

## Exclusivo andistro distros
distro_desc_line_d1="    --boot  comando para iniciar alguma configuração."
distro_desc_line_d2="Subcomandos do --boot"
distro_desc_line_d3="    vnc  para iniciar o servidor VNC"
distro_desc_line_d4="Subcomandos do --boot vnc"
distro_desc_line_d5="    --display  define a resolução da tela que será exibida"
distro_desc_line_d6="    --scale    define a escala da tela (1 ou 2)"
distro_desc_line_d7="    --port     define a porta usada pelo servidor."
distro_desc_line_d8="O comando --scale só funciona no xfce4, caso use no lxde, o comando será ignorado"
distro_desc_line_d9="O comando --display e --port não são obrigatórios e caso não use o servidor será iniciado na resolução e porta padrão."
distro_desc_line_d10="Exemplo de comando que permite a inicialização do servior vnc"
distro_desc_line_d11="Modo simples"
distro_desc_line_d12="   andistro --boot vnc"
distro_desc_line_d13="Modo completo"
distro_desc_line_d14="   andistro --boot vnc --display 1920x1080 --port 1 --scale 1"
distro_desc_line_d15="Uso: andistro --termux-cmd \"COMANDO_DO_TERMUX\""
#//////////////////////////////////////////////////////////////////////////////////////////////////////
#=====================================================================================================

#=====================================================================================================
# Aguardos e carregamentos 
label_progress="Em andamento..."
label_upgrade="Atualizando o sistema..."
label_wait="Aguarde"

# Baixar
label_distro_download="Baixando o %s..."
label_distro_download_finish="A ultima versão do %s foi baixada com sucesso."
label_distro_download_start="Em breve será baixado a ultima versão do %s para o armazenamento..."
label_install_script_download="Baixando os arquivos necessários..."
label_skip_download="Pulando o download"
label_update_finish="Atualização concluída!"
label_wallpaper_download="Baixando papéis de parede..."

# Configurações
label_keyboard_setup="Iniciando as configurações do teclado, aguarde...."
label_keyboard_active_sugest="Caso necessário toque no botão para abrir o teclado (⌨)"
label_system_setup="Configurando o sistema..."
label_xdg_user_dirs_setup="Configurando as pastas padrões para o sistema..."

# Informativos
commands_available_to_you="Comandos disponíveis para você:"
label_command_not_found="Comando não encontrado:"
label_dialog_display_menu_sugestion="Sugestões de Resolução"
label_dialog_display_menu_sugestion_desc="Deseja que toda vez que o sistema seja iniciado, apareça uma caixa de diálogo com sugestões de resolução de tela?"
label_dialog_uninstall_menu="Deseja continuar com a desinstalação?"
label_dialog_uninstall_menu_desc="Você está prestes a desinstalar o sistema %s.\n\nTodos os dados relacionados a este sistema serão perdidos. \nESTE É UMA AÇÃO IRREVERSÍVEL.\n\nDeseja continuar?"
label_termux_settings="Configurações do Termux"
label_open_termux_settings="Após clicar em \"Ok\" será aberto a as informações do Termux no sistema."

## Fuso horário
label_system_timezone="Fuso horário"
label_distro_alert_timezone_desc="O fuso horário será o mesmo do dispositivo."
label_distro_alert_timezone_detected="Fuso horário detectado: "

# Alertas
label_uninstall_success="Desinstalação concluida!"
label_uninstalling_system="Desinstalando o sistema %s"
label_uninstall_cancelled="A desinstalação do sistema %s foi cancelada"
label_install_success="Instalação concluida!"
label_setup_apply="Configuração aplicada!"

# Senhas
label_change_password="A senha foi alterada com sucesso. "
label_password_forgot="Esqueceu a senha? Use o comando 'andistro --boot vnc --passwd' para redefinir a senha."
label_password_input="Digite a nova senha para o servidor VNC"
label_password_input_alert_important="É necessário definir uma senha!"
label_password_save_failed="Falha ao salvar a senha!"

# Escolhas
label_choose_one_of_the_option="Escolha uma das opções"
label_choose_language="Escolha o idioma "
label_choose_theme="Escolha um tema"

#Indisponibilidade
label_command_not_available="Este comando não está disponível para o sistema atual."
label_system_not_found="Sistema não encontrado."

#Erros e recusas
label_entry_canceled="Entrada cancelada pelo usuário."
label_command_problem_andistro_for_distro="Este comando só funciona se encerrar o sistema."
label_error_dir_termux_home_not_accessible="Erro: diretório /termux/home não está acessível dentro do Debian"
label_error_bridge_unavailable="Erro: bridge indisponível"
label_action_denied="Ação recusada"
label_problem="Houve um problema"

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
label_localhost="Local"
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
label_help="Ajuda"


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

# Permissões
label_permission_granted="Já permiti"
label_permission_retired="Já retirei"
label_permission_not_granted="Não consegui"
label_permission_help="Ajuda com permissão"
label_open_configs="Abrir configs."
label_delay_later="Vou deixar para depois"
label_stop_and_open="Você escolheu parar. Nada foi aberto."
label_action_denied="Ação: recusado (ESC) ou CTRL+C."
label_invalid_key="Tecla inválida, questionário finalizado."
label_no_open="Você escolheu NÃO abrir. Nada foi aberto."
label_cancel_action="Você escolheu cancelar a ação."
label_continue_action="Você escolheu seguir com a ação."
label_cancel_action_ctrlc="Você apertou CTRL+C. Você escolheu NÃO executar. Nada foi feito."
label_cancel_action_esc="Você apertou ESC. Você escolheu NÃO executar. Nada foi feito."
label_continue_action_executed="Você escolheu executar. Um momento..."
label_action_accepted="O pedido foi aceito."

label_storage_permission="Permissão de armazenamento"
label_storage_permission_desc="Permitir que o AnDistro tenha acesso e possa gerenciar o armazenamento do celular.\n\nIsto permite que acesse fotos, vídeos, música, áudios e outros arquivos neste dispositivo."
label_storange_permission_help_desc="Clique no botão \"Permitir acesso\" nas configurações para liberar o acesso ao armazenamento.\n\nDepois de permitir, volte ao Termux e pressione \"Já permiti\"."
label_battery_optimization="Otimização de bateria"
label_battery_optimization_desc="Para evitar que o sistema encerre o Termux/AnDistro em segundo plano, é recomendado retirar a otimização de bateria.\n\nNa próxima tela, procure pelo aplicativo Termux, abra-o e escolha o modo \"Sem restrições\" ou \"Não restrito\"."
label_battery_optimization_desc_info="Você já ajustou a otimização de bateria do Termux para \"Sem restrições\" / \"Não restrito\"?\n\nTanto faz a opção escolhida, este passo será finalizado agora."
label_open_avnc="Abrindo AVNC..."
label_open_avnc_desc="Deseja abrir o aplicativo AVNC?\nCaso sim, tecle ENTER (↲), caso contrário, tecle ESC ou CTRL+C para ignorar."
label_open_avnc_success="Você escolheu abrir o AVNC. Um momento..."
label_open_avnc_failed="O aplicativo AVNC não abriu.\n\nIsso pode acontecer se o app não estiver instalado ou se a ponte com o Termux não estiver funcionando.\n\nClique em ajuda para abrir uma página que explica como baixar e instalar o AVNC?"

# Temporizador
label_sleep_in_10s="Esta mensagem desaparecerá em 10 segundos."

# Sistema
label_distro_boot="O sistema %s foi iniciado"
label_distro_not_installed="O %s não está instalado."
label_distro_not_installed_desc="O %s ainda não foi instalado, siga os passos abaixo para a instalação:\nDigite o comando 'andistro' seguido do enter  (↲), escolha a opção instalar. Depois escolha o %s para iniciar a instalação."
label_distro_installed="O %s já está instalado."

# Servidor
label_server_kill_desc="Desligando o servidor..."
label_server_kill_desc_help="Para desligar o servidor VNC, use o comando 'andistro --boot vnc --kill'"
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
label_resolution_option_default_desc="Confirme para iniciar com a resolução definida como padrão. \n\nAperte no '<Sim>' para confirmar ou tecle enter (↲). \nAperte no '<Não>' para escolher outra resolução."
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