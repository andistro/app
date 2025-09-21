# 📄 **Documentação**

<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px"> ![ForYou](https://img.shields.io/badge/-Criado_com_❤️-gray)
![Android](https://img.shields.io/badge/Android-gray?logo=android)
![Termux](https://img.shields.io/badge/Termux-gray?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0OCA0OCI+CgogICAgPCEtLSBTY3JlZW4gYW5kIGJvcmRlci4gLS0+CiAgICA8cGF0aCBmaWxsPSIjMDAwIgogICAgICAgICAgc3Ryb2tlPSIjQkZDQkNEIgogICAgICAgICAgc3Ryb2tlLXdpZHRoPSIyIgogICAgICAgICAgZD0iTTksNgogICAgICAgICAgICAgbDMwLDAKICAgICAgICAgICAgIHEzIDAsMyAzCiAgICAgICAgICAgICBsMCwzMAogICAgICAgICAgICAgcTAgMywgLTMgMwogICAgICAgICAgICAgbC0zMCwwCiAgICAgICAgICAgICBxLTMgMCwgLTMtMwogICAgICAgICAgICAgbDAgLTMwCiAgICAgICAgICAgICBxMCAtMywgMyAtMyIKICAgIC8+CgogICAgPCEtLSBCbG9jayBjdXJzb3IuIC0tPgogICAgPHBhdGggZmlsbD0iI0ZGRiIKICAgICAgICAgIGQ9Ik0xNCwxNAogICAgICAgICAgICAgbDUsMAogICAgICAgICAgICAgbDAsMTAKICAgICAgICAgICAgIGwtNSwwIgogICAgLz4KCjwvc3ZnPgo=)

|📄|Documentação|
|-|-|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px" alt="Bandeira do Brasil">|[Português do Brasil (pt-BR)](/wiki/pt-BR/README.md)|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="Bandeira dos Estados Unidos">|[English of United States (en-US)](/wiki/en-US/README.md)|

| **Comece selecionando alguma das opções abaixo.** |
|--------------------|
|[**Requisitos**](#Requisitos---)|
||
|[**Instalações necessárias**](#Instalações-necessárias---)|
||
|[**Iniciando a Instalação do sistema**](#iniciando-a-Instalação-do-sistema---)|
|  **↳** [**Baixando o instalador**](#baixando-o-instalador---)|
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

# **Instale distribuições Linux dentro do ambiente Android e sem root.**

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

# Requisitos [[ ↑ ]](#)

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

# Instalações necessárias [[ ↑ ]](#)

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


# Iniciando a Instalação do sistema [[ ↑ ]](#)

## Baixando o instalador [[ ↑ ]](#)

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
> curl -O https://raw.githubusercontent.com/andistro/app/main/andistro && chmod +x andistro && echo "Aguarde um instante" && bash andistro -u
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