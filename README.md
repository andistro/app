<!--
📄  Documentação
-->

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
<hr>
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
- Instalar o Ubuntu em dispositivos Android;
- Adicionar repositórios que não estão presentes nos repositórios do Ubuntu;
- Atualizar o repositório do Firefox para que possa ser instalado a partir de um PPA ao invés do instalador snap (padrão) que não funciona no android;
- Instalar o Figma para linux com suporte ao arm;
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



















```bash
apt update -y && apt install wget -y && wget https://raw.githubusercontent.com/distribuicoeslinuxnoandroid/app/main/instalar && chmod +x instalar && mv instalar $PREFIX/bin/instalar && instalar distro
```

```bash
apt update -y && apt install wget -y && wget https://raw.githubusercontent.com/distribuicoeslinuxnoandroid/app/main/start.sh -O distrolinux-install.sh && chmod +x distrolinux-install.sh && bash distrolinux-install.sh
```