# 📄 Documentação

<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px"> ![ForYou](https://img.shields.io/badge/-Criado_com_❤️-gray)
![Android](https://img.shields.io/badge/Android-gray?logo=android)
![Termux](https://img.shields.io/badge/Termux-gray?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0OCA0OCI+CgogICAgPCEtLSBTY3JlZW4gYW5kIGJvcmRlci4gLS0+CiAgICA8cGF0aCBmaWxsPSIjMDAwIgogICAgICAgICAgc3Ryb2tlPSIjQkZDQkNEIgogICAgICAgICAgc3Ryb2tlLXdpZHRoPSIyIgogICAgICAgICAgZD0iTTksNgogICAgICAgICAgICAgbDMwLDAKICAgICAgICAgICAgIHEzIDAsMyAzCiAgICAgICAgICAgICBsMCwzMAogICAgICAgICAgICAgcTAgMywgLTMgMwogICAgICAgICAgICAgbC0zMCwwCiAgICAgICAgICAgICBxLTMgMCwgLTMtMwogICAgICAgICAgICAgbDAgLTMwCiAgICAgICAgICAgICBxMCAtMywgMyAtMyIKICAgIC8+CgogICAgPCEtLSBCbG9jayBjdXJzb3IuIC0tPgogICAgPHBhdGggZmlsbD0iI0ZGRiIKICAgICAgICAgIGQ9Ik0xNCwxNAogICAgICAgICAgICAgbDUsMAogICAgICAgICAgICAgbDAsMTAKICAgICAgICAgICAgIGwtNSwwIgogICAgLz4KCjwvc3ZnPgo=)

| WIKI ||
|-|-|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px" alt="Bandeira do Brasil">|[Português do Brasil (pt-BR)](/wiki/pt-BR/README.md)|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="Bandeira dos Estados Unidos">|[English of United States (en-US)](/wiki/en-US/README.md)|

| **Comece selecionando alguma das opções abaixo.** |
|--------------------|
|[**Requisitos**](#Requisitos)|
||
|[**Instalações necessárias**](#Instalações-necessárias)|
||
|[**Iniciando a Instalação do sistema**](#niciando-a-Instalação-do-sistema)|
|  **↳** [**Baixando o instalador**](#baixando-o-instalador)|
||
|[**Resolução de problemas**](/wiki/pt-BR/bugs.md)|
||
|[**DevTools ‐ Padrões de interface de código**](/wiki/pt-BR/DevTools.md)|


<!--
h1
|[** **]()|
h1 alt
|**↳** [** **]()|
h2
|  **↳** [** **]()|
h3
|    **↳** [** **]()|
h4
|      **↳** [** **]()|
-->

<!-- **Instale distribuições famosas dentro do ambiente Android e sem root.** -->
**Instale distribuições Linux dentro do ambiente Android e sem root.**

Este é um projeto que permite instalar distribuições Linux, como Ubuntu e Debian em dispositivos Android sem necessidade de root. O sistema é executado dentro do ambiente Termux e utiliza VNC para fornecer uma interface gráfica completa, sem modificar as configurações do Android.

Para garantir a confiança e segurança, nenhum sistema é hospedado no repositório - todos são baixados diretamente dos sites oficiais das distribuições. O código do instalador está completamente aberto para verificação


> [!NOTE]
> Esse script de instalação foi feito para dispositivos Android com a arquitetura ARM64

> [!IMPORTANT]
> Todo o sistema será execultado dentro do Termux e por não haver root, não irá modificar as configurações do Android. <br>
> Para garantir a confiança desse projeto, nenhum sistema é hopedado aqui, todos sào baixados diretamente no site oficial do sistema operacional.<br>
> O código desse instalador está totalmente aberto para que possa conferir cada arquivo.<br>

>[!WARNING]
> Esse instalador é testado várias vezes, e usa ferramentas oficiais para funcionar e garantir a segurança dos dados, mas caso você instale algum arquivo desconhecido e que contenha malware, não é garantido que não afete a memória interna do aparelho visto que mesmo que o malware execulte somente dentro da maquina virtual, o sistema pode ler e modificar os arquivos da memória interna. Só nã há a possibilidade de modificar arquivos protegidos de sistema como exemplo os da pasta `Android/data`.

# Requisitos

|||Recomendado|Mínimo|Não suportado|
|-|-|-|-|-|
|![Arquiteturas suportadas](https://img.shields.io/badge/-gray?logo=arm&logoColor=white)|Arquiteturas| ![Arm](https://img.shields.io/badge/ARM64-0091BD) | ![Arm](https://img.shields.io/badge/ARMHF-0091BD) |![x86_64](https://img.shields.io/badge/x86__64-gray)|
|![Armazenamento](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJNMTIwLTE2MHYtMTYwaDcyMHYxNjBIMTIwWm04MC00MGg4MHYtODBoLTgwdjgwWm0tODAtNDQwdi0xNjBoNzIwdjE2MEgxMjBabTgwLTQwaDgwdi04MGgtODB2ODBabS04MCAyODB2LTE2MGg3MjB2MTYwSDEyMFptODAtNDBoODB2LTgwaC04MHY4MFoiLz48L3N2Zz4=)|Espaço livre no armazenamento|![64GB](https://img.shields.io/badge/Acima_de_64GB-FBBC04)|![40GB](https://img.shields.io/badge/40GB-gray)|
|![Memória ram](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJNMjQwLTM2MGg4MHYtMjQwaC04MHYyNDBabTIwMCAwaDgwdi0yNDBoLTgwdjI0MFptMjAwIDBoODB2LTI0MGgtODB2MjQwWm0tNDgwIDgwaDY0MHYtNDAwSDE2MHY0MDBabTAgMHYtNDAwIDQwMFptNDAgMTYwdi04MGgtNDBxLTMzIDAtNTYuNS0yMy41VDgwLTI4MHYtNDAwcTAtMzMgMjMuNS01Ni41VDE2MC03NjBoNDB2LTgwaDgwdjgwaDE2MHYtODBoODB2ODBoMTYwdi04MGg4MHY4MGg0MHEzMyAwIDU2LjUgMjMuNVQ4ODAtNjgwdjQwMHEwIDMzLTIzLjUgNTYuNVQ4MDAtMjAwaC00MHY4MGgtODB2LTgwSDUyMHY4MGgtODB2LTgwSDI4MHY4MGgtODBaIi8+PC9zdmc+)|Memória RAM|![](https://img.shields.io/badge/Acima_de_6GB-orange)|
|![Versão do Android](https://img.shields.io/badge/-gray?logo=android&logoColor=white)|Android|![Android 10+](https://img.shields.io/badge/Android_10+-073042)|
|![Root](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJtMjQwLTE2MCA0MC0xNjBIMTIwbDIwLTgwaDE2MGw0MC0xNjBIMTgwbDIwLTgwaDE2MGw0MC0xNjBoODBsLTQwIDE2MGgxNjBsNDAtMTYwaDgwbC00MCAxNjBoMTYwbC0yMCA4MEg2NjBsLTQwIDE2MGgxNjBsLTIwIDgwSDYwMGwtNDAgMTYwaC04MGw0MC0xNjBIMzYwbC00MCAxNjBoLTgwWm0xNDAtMjQwaDE2MGw0MC0xNjBINDIwbC00MCAxNjBaIi8+PC9zdmc+)|Root|![Não é necessário](https://img.shields.io/badge/Não_é_necessário-red)|
|![ADB](https://img.shields.io/badge/-gray?logo=android&logoColor=white)|ADB|![Pode ser necessário](https://img.shields.io/badge/Necessário_no_Android_12,_13_e_14-073042)|



|||Suportado|Com falhas|Em teste|
|-|-|-|-|-|
||Sistemas| ![Debian](https://img.shields.io/badge/Debian-13-red?logo=debian&logoColor=white) <br>![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu&logoColor=white)|
||Interface gráfica| ![XFCE](https://img.shields.io/badge/XFCE-2284F2?logo=xfce&logoColor=white)|

> [!CAUTION]
> Usar o sistema em um dispositivo mais fraco pode causar sobrecarga e danificar componentes internos devido a alta demanta de processamento.

# Instalações necessárias

Para que tudo funcione corretamente, é necessário a instalação do **Termux**, do **Andronix** e do **AVNC**. O Termux irá instalar e executar a distribuição localmente, o Andronix disponibilizará o script de instalação da distribuição e o AVNC irá visualizar e possibilitar o uso da interface gráfica do Ubuntu.
|**Onde baixar**|
|------|
||
|**Termux**|
|<a href="https://github.com/termux/termux-app/releases" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-github.png" alt="Baixe pelo GitHub"></a> <a href="https://f-droid.org/pt_BR/packages/com.termux/" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-fdroid.png" alt="Baixe pelo F-Droid"></a>|
|**AVNC**|
|<a href="https://github.com/gujjwal00/avnc/releases" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-github.png" alt="Baixe pelo GitHub"></a><a href="https://f-droid.org/pt_BR/packages/com.gaurav.avnc/" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-fdroid.png" alt="Baixe pelo F-Droid"></a> <a href="https://play.google.com/store/apps/details?id=com.gaurav.avnc" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-google-play.png" alt="Baixe pelo Google Play Store"></a>|
> [!WARNING]
> O Termux da Google Play Store está desatualizado e não há mais suporte oficial.

# Ativar o modo desenvolvedor do Android

> [!CAUTION]
> Esta é uma área de risco. Todas as configurações aqui listadas são modificações de nível de sistema. Caso não saiba o que está fazendo, busque descobrir o que cada coisa faz e como poder reverter a situação antes de executar os comandos. <br>
> Em alguns casos será necessário restaurar o aparelho aos padrões de fábrica, em outros casos poderão ser necessário ter que reinstalar o sistema operacional novamente no aparelho. <br>
> Os processos de `adb` podem sofrer alterações a depender do aparelho e versão do Android.

> [!NOTE]
> Os passos podem mudar a depender de como o fabricante do dispositivo optou em posicionar a função.

1. Abrir as configurações do sistema;
2. Ir até opção "sobre o telefone";
3. Acessar as informações do sistema;
4. Clicar 5 ou mais vezes na opção chamada "número de compilação" até aparecer a solicitação de senha de desbloqueio.
5. Digite a senha que usa para desbloquear o aparelho;
6. Aparecerá um alerta toast de que o modo desenvolvedor está ativo;
7. Volte para o início das configurações do sistema.

# Corrigindo o problema da parada forçada do sistema no Termux ‐ `[Process completed (signal 9) ‐ press Enter]`

## Sobre o problema

> [!CAUTION]
> Esta é uma área de risco. Todas as configurações aqui listadas são modificações de nível de sistema. Caso não saiba o que está fazendo, busque descobrir o que cada coisa faz e como poder reverter a situação antes de executar os comandos. <br>
> Em alguns casos será necessário restaurar o aparelho aos padrões de fábrica, em outros casos poderão ser necessário ter que reinstalar o sistema operacional novamente no aparelho. <br>
> Os processos de `adb` podem sofrer alterações a depender do aparelho e versão do Android.


Desde o Android 12, o Termux e outros aplicativos receberam restrições sobre o uso da CPU do aparelho. Isso é melhor explicado pelo [Agnostic-apollo em uma documentação chamada de "Phantom, Cached And Empty Processes"](https://github.com/agnostic-apollo/Android-Docs/blob/master/en/docs/apps/processes/phantom-cached-and-empty-processes.md). Em um breve resumo, o Android está limitando o desempenho de qualquer aplicativo que tente usar de forma excessiva a CPU e por causa dessa restrição, o Termux, app usado para instalar a distribuição Linux dentro do Android apresenta o erro `[Process completed (signal 9) - press Enter]` e força a parada do sistema, forçando o usuário a reiniciar o aplicativo e reiniciar o servidor local.

Mesmo com esta restrição, existe alternativas para podermos desabilitar esta restrição, mas para isso acontecer será necessário ter acesso às opções de desenvolvedor do celular. Em uma das formas será usando o próprio Termux, adb e a depuração Wi-Fi das opções do desenvolvedor para desabilitar o `settings_enable_monitor_phantom_procs`

> [!NOTE]
> Na OneUI 7 da Samsung, será necessário desabilitar o bloqueador automático em `configurações > segurança e privacidade > bloqueador automático`. Caso contrário, não será possível habilitar à depuração Wi-Fi e o sistema irá criar barreiras de restrição.

<br><br>

## Desabilitando o Phantom Process no Android 12 e 13

### Desativar o monitor de processos fantasmas pelo `sinalizadores de recursos`
> [!NOTE]
> Nem todos os dispositivos terão a possibilidade de usar esse passo.
1. Ative as opções do desenvolvedor. [O tutorial está aqui](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Vá até as opções do desenvolvedor. Normalmente é a última opção das configurações do seu aparelho;
2. Procure pela opção `sinalizadores de recursos`;
3. Desative a opção `settings_enable_monitor_phantom_procs`;
<br><br>

### Desativar o monitor de processos fantasmas pelo `adb`
#### Permitir que o Termux use o `adb`

> [!CAUTION]
> Será necessário usar o `adb`. Atente-se, pois, o `adb` pode fazer modificações agressivas no sistema Android e em alguns casos será necessário restaurar o aparelho aos padrões de fabrica ou até mesmo fazer uma reinstalação do sistema caso remova algo essencial para o funcionamento. O que será dito aqui já foi documentado em vários portais na internet cada fabricante poderá criar diferentes restrições encima do comando.

> [!WARNING]
> Se nunca usou ou nem conheçe o `adb`, essa documentação não trará detalhes aprofundados sobre a ferramenta e por isso, recomendo que se aprofunde mais em outras páginas, principalmente na do Android.
> - [Android Debug Bridge (adb)](https://developer.android.com/tools/adb)

> [!NOTE]
> O `adb` já vem instalado no sistema Android, portanto não precisa ser instalado. Para esse processo que visa resolver o problema do `process 9` será necessesário usar um app que possa ter permissões de desenvolvedor e que possa executar os comandos necessários para desativar o os processos fantasmas. Nessa documentação, será usado o próprio Termux, mas dependendo do aparelho, poderá ser necessário utilizar um computador.


1. Ative as opções do desenvolvedor. [O tutorial está aqui](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Vá até as opções do desenvolvedor. Normalmente é a última opção das configurações do seu aparelho;
3. Procure pela opção `depuração por wi-fi` abra e ative-a;
4. Abra o Termux como multi janela;
    <details><summary>Exemplo</summary><img height="500px" margin="10px" alt="image" src="https://github.com/user-attachments/assets/f1bfa6b4-a56b-40da-967e-346e21194578" /><br><a href="https://github.com/user-attachments/assets/f1bfa6b4-a56b-40da-967e-346e21194578" target="_blank">Expandir imagem</a><br><br><img height="500px" alt="image" src="https://github.com/user-attachments/assets/e2ae59c0-fdfd-45ea-a93e-1659e486ed18"/><br><a href="https://github.com/user-attachments/assets/e2ae59c0-fdfd-45ea-a93e-1659e486ed18" target="_blank">Expandir imagem</a></details>
> [!TIP]
> A ordem das janelas não é importante, o que importa é que os dois apps esteja em multi-janela como no exemplo.

5. No Termux, instale o pacote `android-tools`:
```shell
pkg install android-tools -y
```
6. Em depuração Wi-FI, clique na opção `parear o dispositivo com um código de pareamento` e execute o comando abaixo no Termux e tecle `enter` para confirmar, mas primeiro, se atente às condições abaixo:
```shell
adb pair <IP Address and port> <wireless pairing code>
# Exemplo: 
# adb pair localhost:12345 123456
# adb pair 192.168.1.2:12345 123456
```
> [!NOTE]
> Trocar o `<IP Address and port>` pelo link que aparece abaixo de `endereço IP e porta`. <br>
> Trocar o <wireless pairing code> pelo código que aparece em `código de pareamento por Wi-Fi.`

> [!IMPORTANT]
> A porta e código de pareamento podem mudar quando a tela do aparelho apagar ou quando sair do aplicativo e por isso que o Termux deve ser aberto em multi janela, para que o código não seja reiniciado antes do pareamento.<br>
> O endereço IP poderá ser `localhost` e é recomendado porque se a rede Wi-Fi for reiniciada, o endereço IP poderá ser alterado e consecutivamente, o `adb pair` não irá funcionar por não encontrar o link.

> [!NOTE]
> Quando pareado, aparecerá uma mensagem de sucesso em inglês

8. Verifique a lista de dispositivos pareados usando o comando `adb devices`. Caso apareça a mensagem `List of devices attached` e mais nenhuma outra mensagem listando os dispositivos pareados, deverá fazer o pareamento do Termux para executar os comandos `adb`.
9. Execute o comando `adb connect` para reconectar o Termux ao adb via WI-FI
```shell
adb connect <IP Address and port>
```
#### Desativando o monitor de processos fantasmas pelo Termux

> [!CAUTION]
> Como informado, todos os comandos de `adb` presentes nessa página são de modificação do sistema e os mesmos podem causar problemas que só serão resolvidos em caso de restauração aos padrões de fábrica e talvez até sejam irreversíveis. Tome cuidado, se continuar será por sua conta e risco.

> [!NOTE]
> Nem todos os aparelhos tem a possibilidade de usar o `adb` diretamente no dispositivo e serão dependentes de um computador com Windows, macOS ou Linux.

1. Verifique os dispositivos pareados usando o comando abaixo. Certifique que Termux esteja pareado para continuar os próximos passos.
```shell
adb devices
```
>[!NOTE]
> Caso o Termux não esteja conectado, siga os passos do item 8, 9 e 10 do passo: [dar as permissões de `adb` para o Termux](#dar-as-permissões-de-adb-para-o-termux).

2. Execute os seguintes comandos:
>[!NOTE]
> Lembre-se de teclar `enter` quando executar qualquer um dos códigos.

```shell
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
```
```shell
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
```
<!-- este comando irá mostra executou: adb shell "/system/bin/device_config list activity_manager" -->

```shell
adb shell settings put global settings_enable_monitor_phantom_procs false
```
Pronto. Não será necessário reiniciar o aparelho e caso deseje, poderá desativar as opções do desenvolvedor para não implicar com outros aplicativos que não funcionam quando a opção está habilitada, como exemplo, apps governamentais e bancários.

>[!NOTE]
> Para verificar se funcionou, execute os comandos abaixo um por um
```bash 
adb shell "/system/bin/dumpsys activity settings | grep max_phantom_processes"
```
```bash
adb shell "/system/bin/device_config get activity_manager max_phantom_processes"
```
>[!NOTE]
> Esperasse que retorne o valor `2147483647`


<br><br><br>

## Desabilitando o Phantom Process no Android 14 e 15
1. Ative as opções do desenvolvedor. [O tutorial está aqui](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Vá até as opções do desenvolvedor. Normalmente é a última opção das configurações do seu aparelho;
3. Procure por `desabilitar restrições do processo secundário` e habilite a opção.

>[!NOTE]
> Diferente do `adb`, este necessita que as `opções do desenvolvedor` se mantenham ativada.


# Iniciando a Instalação do sistema

## Baixando o instalador

A primeira etapa mais importante será a de instalar os aplicativos para o funcionamento do instalador. [Está listado aqui](https://github.com/andistro/app/wiki/Instala%C3%A7%C3%B5es-necess%C3%A1rias).

Após o Termux ter sido instalado no aparelho e iniciado, agora será a vez de baixar o arquivo que irá fazer o sistema funcionar no celular. Siga os passos abaixo:

1. Digite ou copie e cole o código abaixo no [Termux](intent://#Intent;package=com.termux;scheme=termux;end) e após, tecle enter (↵) para baixar o arquivo:
```bash
curl -O https://raw.githubusercontent.com/andistro/app/main/andistro
```

2. Digite ou copie e cole o código abaixo no Termux para que o arquivo tenha permissão para funcionar:
```bash
chmod +x andistro
```
3. Digite ou copie e cole o código abaixo no Termux para que o arquivo seja iniciado:
```bash
bash andistro -u
```
> [!NOTE]
> O comando `-u` força a atualização e a configuração da ferramenta. Caso não use,a ferramenta poderá apresentar problemas de execução.


> [!NOTE]
> Pode usar esse comando direto, caso não queira executar um comando por vez
> ```bash
> curl -O https://raw.githubusercontent.com/andistro/app/main/andistro && chmod +x andistro && bash andistro -u
> ```

4. O arquivo irá finalizar as configurações necessárias e mostrará uma explicação de como instalar, desinstalar e iniciar os sistemas.

> [!NOTE]
> O arquivo detecta o idioma do sistema e irá iniciar em algum dos idiomas disponíveis a depender do seu sistema.

```bash
Use: andistro <comando> <opção> para seja feito a tarefa desejada.

Exemplo de comando que permite a instalação:

    andistro -i debian

Exemplo de comando que permite a desinstalação:
   andistro -d debian

Exemplo de comando que permite a inicialização:
   andistro -s debian

Comandos:
    -u    - atualiza todos os pacotes.
    -i    - instala a opção escolhida.
    -d    - desinstala a opção escolhida.
    -s    - inicializa a versão escolhida.

Opções:
    debian
    ubuntu
```

>[!NOTE]
> Caso digite o comando `andistro` sem nenhum acréscimo e tecle enter (↵), aparecerá o menu de escolha.