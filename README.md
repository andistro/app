<!--
📄  Documentação
-->


<h3 align="left">Connect with me:</h3>
<p align="left">
<a href="https://linkedin.com/in/andistro" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="andistro" height="30" width="40" /></a>
</p>

<h3 align="left">Languages and Tools:</h3>
<p align="left"> <a href="https://www.gnu.org/software/bash/" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/gnu_bash/gnu_bash-icon.svg" alt="bash" width="40" height="40"/> </a> <a href="https://www.figma.com/" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/figma/figma-icon.svg" alt="figma" width="40" height="40"/> </a> </p>


![Distribuições Linux no Android](https://raw.githubusercontent.com/distribuicoeslinuxnoandroid/.github/main/profile/thumbnail.png)

# Distribuições Linux no Android
Instale distribuições famosas dentro do ambiente Android e sem root.

O repositório Ubuntu no Android permite instalar o Ubuntu ARM64 em dispositivos Android sem root, com o uso do terminal Termux e uma VNC.
> [!NOTE]
> Esse script de instalação foi feito para dispositivos Android com a arquitetura ARM64

> [!IMPORTANT]
> Todo o sistema será execultado dentro do Termux e por não haver root, não irá modificar as configurações do Android. <br>
> Para garantir a confiança desse projeto, nenhum sistema é hopedado aqui, todos sào baixados diretamente no site oficial do sistema operacional.<br>
> O código desse instalador está totalmente aberto para que possa conferir cada arquivo.<br>

>[!WARNING]
> Esse instalador é testado várias vezes, e usa ferramentas oficiais para funcionar e garantir a segurança dos dados, mas caso você instale algum arquivo desconhecido e que contenha malware, não é garantido que não afete a memória interna do aparelho visto que mesmo que o malware execulte somente dentro da maquina virtual, o sistema pode ler e modificar os arquivos da memória interna. Só nã há a possibilidade de modificar arquivos protegidos de sistema como exemplo os da pasta `Android/data`.
---
<br>
<br>

| **Comece selecionando alguma das opções abaixo.** |
|--------------------|
|[**Como funciona?**](#)|
||
|[**Qual a função desse script?**](#)|
||
|[**Requisitos mínimos**](#)|
||
|[**Instalações necessárias**](#)|
||
|[**Fazendo a instalação**](#)|
|  **↳** [**Passo 1 - instalando a distribuição**](#)|
|  **↳** [**Passo 2 - iniciando a interface gráfica**](#)|
|  **↳** [**Passo 3 - finalizando o sistema**](#)|

<!--
h1
|[** **]()|
h1 alt
|**↳** [** **]()|
h2
|  **↳** [** **]()|
h3
|    **↳** [** **]()|
-->

<br>
<br>

# Como funciona?
O script de instalação deste repositório usa o [PRoot](https://wiki.termux.com/wiki/PRoot) para executar a distribuição Linux em seus dispositivos Android sem root.

<br>
<br>

# Qual a função desse script?
- instalar o Ubuntu em dispositivos Android;
- Adicionar repositórios que não estão presentes nos repositórios do Ubuntu;
- Atualizar o repositório do Firefox para que possa ser instalado a partir de um PPA ao invés do instalador snap (padrão) que não funciona no android;
- instalar o Figma para linux com suporte ao arm;
- Corrigir o problema de iniciação do vscode, figma linux, brave-browser e vivaldi, que não são auto-abertos em máquina virtual sem o comando `--no-sandbox`;
- Trocar o idioma do sistema operacional para o Português do Brasil.


<br>
<br>

# Requisitos mínimos
Para o bom funcionamento do sistema, será necessário que atenda às especificações abaixo
|   | Requisito mínimo | Recomendável |Aceito, mas não recomendado |
| ------------- | --- | ------------- | ---- |
|Sistema operacional| Android 10 ou superior|
| RAM  | 6GB  | 8GB ou mais | 4GB|
|Memória interna do aparelho| 128GB¹ | 256GB ou mais|
|Espaço livre| 40GB de espaço livre na memmória interna|
|Apps| Termux, aplicativo de VNC da sua escolha|
|Adicional|Devido restrições do Android, a depender da versão disponível no seu aparelho será necessário desativar o Phantom Process|

>[!NOTE]
>¹ O sistema não inicia em aparelhos que possuem a memória interna de 64GB ou 32GB

> [!CAUTION]
> Usar o sistema em um dispositivo mais fraco pode causar sobrecarga e danificar componentes internos devido a alta demanta de processamento.
<br>
<br>


# Instalações necessárias
Para que tudo funcione corretamente, é necessário a instalação do **Termux**, do **Andronix** e do **AVNC**. O Termux irá instalar e executar a distribuição localmente, o Andronix disponibilizará o script de instalação da distribuição e o AVNC irá visualizar e possibilitar o uso da interface gráfica do Ubuntu.
|**Onde baixar**|
|------|
||
|**Termux**|
|<a href="https://github.com/termux/termux-app/releases" target="_blank"><img width="256px" src="/Doc/assets/badges/get-it-on-github.png" alt="Baixe pelo GitHub"></a> <a href="https://f-droid.org/pt_BR/packages/com.termux/" target="_blank"><img width="256px" src="/Doc/assets/badges/get-it-on-fdroid.png" alt="Baixe pelo F-Droid"></a>|
|**AVNC**|
|<a href="https://github.com/gujjwal00/avnc/releases" target="_blank"><img width="256px" src="/Doc/assets/badges/get-it-on-github.png" alt="Baixe pelo GitHub"></a> <a href="https://f-droid.org/pt_BR/packages/com.gaurav.avnc/" target="_blank"><img width="256px" src="/Doc/assets/badges/get-it-on-fdroid.png" alt="Baixe pelo F-Droid"></a> <a href="https://play.google.com/store/apps/details?id=com.gaurav.avnc" target="_blank"><img width="256px" src="/Doc/assets/badges/get-it-on-google-play.png" alt="Baixe pelo Google Play Store"></a>|
> [!WARNING]
> O Termux da Google Play Store está desatualizado e não há mais suporte oficial.


# Fazendo a instalação

<br>

## Baixando o insalador do sistema

Após o Termux ter sido instalado no aparelho e iniciado, agora será a vez de baixar o arquivo que irá fazer o sistema funcionar no celular. Siga os passos abaixo:

1. Copie e cole o código abaixo no Termux e após, tecle enter (↵) para baixar o arquivo:
```bash
curl -O https://raw.githubusercontent.com/andistro/app/main/andistro > /dev/null 2>&1
```
<details>
<summary>Versão Alpha</summary>

```bash
curl -O https://raw.githubusercontent.com/andistro/app/alpha/andistro > /dev/null 2>&1
```
</details>

2. Copie e cole o código abaixo no Termux para que o arquivo tenha permissão para funcionar:
```bash
chmod +x andistro
```
3. Copie e cole o código abaixo no Termux para que o arquivo seja iniciado:
```bash
./andistro
```
>[!NOTE]
> Irá aparecer uma mensagem de erro por ser a primeira vez que está sendo usado e o arquivo não está na pasta correta. O próprio irá de forma automática ser salvo na pasta correta e irá mostrar um tutorial de como ser usado.<br>

4. Digite ou copie e cole algum dos códigos abaixo no Termux para iniciar a instalação:

> Instalação direta <br>
> No lugar de `<NOME_DA_DISTRIBUIÇÃO>` digite o nome do sistema que será instalado.
```bash
andistro <NOME_DA_DISTRIBUIÇÃO>
```
>[!NOTE]
> Caso digite o comando `andistro` sem nenhum acréscimo e tecle enter (↵), aparecerá um mini guia de como funciona. O mesmo também irá procurar uma atualização para se manter na última versão.

---
>[!NOTE]
> Caso prefira que os passos sejam feitos de uma unica vez, copie o código abaixo
```bash
curl -O https://raw.githubusercontent.com/andistro/app/main/andistro && chmod +x andistro && bash andistro && clear && andistro
```
<details>
<summary>Versão Alpha</summary>

```bash
curl -O https://raw.githubusercontent.com/andistro/app/alpha/andistro && chmod +x andistro && bash andistro && clear && andistro
```
</details>
---

<br>

---

>[!WARNING]
> Os sistemas baseados em Debian tem o mesmo processo de instalação.
---
### Instalando direta 
Para fazer a instalação direta de qualquer um dos sistemas operacionais suportados, será usado o comando `andistro <NOME_DA_DISTRIBUIÇÃO>` para iniciar a instalação. Após isso, Aparecerá uma barra de progresso referente aos pacotes que estão sendo baixados para o sistema funcionar e logo após irá perguntar qual versão irá usar. O instalador organiza com o mais recente primeiro.

1. Baixar o Debian
```bash
andistro debian
```

2. Baixar o Ubuntu
```bash
andistro ubuntu
```
---
>[!WARNING]
> Após executar qualquer um dos comandos citados acima, caso seja a primeira vez que está usando o Termux, irá aparecer a seguinte mensagem:
```bash
Configuration file '/data/data/com.termux/files/usr/etc/bash.bashrc'
 ==> File on system created by you or by a script.
 ==> File also in package provided by package maintainer.
   What would you like to do about it ?  Your options are:
    Y or I  : install the package maintainer's version
    N or O  : keep your currently-installed version
      D     : show the differences between the versions
      Z     : start a shell to examine the situation
 The default action is to keep your current version.
*** bash.bashrc (Y/I/N/O/D/Z) [default=N] ?
```
> Esta mensagem só irá aparecer uma única vez, na primeira atualização interna do Termux. Para sair dessa mensagem, pode digitar `N` e logo após, teclar `enter`(↵) para continuar o progresso de atualização.

## Escolhendo a versão do sistema
Após escolher o sistema operacional de sua preferencia e ter aguardado ser baixado os pacotes necessários para começar a instalação, será necessário escolher a versão do sistema operacional escolhido.

|  |  |
|--|--|
|<img src="/Doc/assets/screenshots/Termux_debian_versoes.jpg" alt="Versões disponíveis do Debian para baixar">|<img src="/Doc/assets/screenshots/Termux_ubuntu_versoes.jpg" alt="Versões disponíveis do Ubuntu para baixar">|
|Versões disponíveis do Debian para baixar|Versões disponíveis do Ubuntu para baixar|

Para escolher qualquer uma das versões de cada sistema operacional, clique no nome da versão e logo após, clique em `OK` para continuar.


## Escolhendo o idioma padrão
Após ter escolhido a versão do sistema, será necessário escolher o idioma que será usado nele. O instalador tem a capacidade de autodefinir para o idioma do sistema, mas por enquanto, como ainda existe poucos pacotes de tradução, a opção segue desabilitada.

<img width="256px" src="/Doc/assets/screenshots/Termux_sistema_idioma.jpg" alt="escolha do idioma">

>[!WARNING]
> Por enquanto o sistema pode ser instalado no idioma padrão, o Inglês, mas o instalador ainda não recebeu o pacote de tradução do idioma inglês.


## Escolhendo a interface, o ambiente da área de trabalho
Essa é uma parte importante para o funcionamento do sistema da forma que conhecemos. Será necessário escolher alguma dessas opções para que possa usar o sistema operacional com uma interface gráfica como acontece nos computadores comuns.

<img width="256px" src="/Doc/assets/screenshots/Termux_sistema_interface.jpg" alt="Ambiente da área de trabalho">