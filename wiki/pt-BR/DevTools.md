# DevTools ‐ Padrões de interface de código

<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px"> ![ForYou](https://img.shields.io/badge/-Criado_com_❤️-gray)
![Android](https://img.shields.io/badge/Android-gray?logo=android)
![Termux](https://img.shields.io/badge/Termux-gray?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0OCA0OCI+CgogICAgPCEtLSBTY3JlZW4gYW5kIGJvcmRlci4gLS0+CiAgICA8cGF0aCBmaWxsPSIjMDAwIgogICAgICAgICAgc3Ryb2tlPSIjQkZDQkNEIgogICAgICAgICAgc3Ryb2tlLXdpZHRoPSIyIgogICAgICAgICAgZD0iTTksNgogICAgICAgICAgICAgbDMwLDAKICAgICAgICAgICAgIHEzIDAsMyAzCiAgICAgICAgICAgICBsMCwzMAogICAgICAgICAgICAgcTAgMywgLTMgMwogICAgICAgICAgICAgbC0zMCwwCiAgICAgICAgICAgICBxLTMgMCwgLTMtMwogICAgICAgICAgICAgbDAgLTMwCiAgICAgICAgICAgICBxMCAtMywgMyAtMyIKICAgIC8+CgogICAgPCEtLSBCbG9jayBjdXJzb3IuIC0tPgogICAgPHBhdGggZmlsbD0iI0ZGRiIKICAgICAgICAgIGQ9Ik0xNCwxNAogICAgICAgICAgICAgbDUsMAogICAgICAgICAgICAgbDAsMTAKICAgICAgICAgICAgIGwtNSwwIgogICAgLz4KCjwvc3ZnPgo=)

|📄|Documentação|
|-|-|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px" alt="Bandeira do Brasil">|[Português do Brasil (pt-BR)](/wiki/pt-BR/README.md)|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="Bandeira dos Estados Unidos">|[English of United States (en-US)](/wiki/en-US/README.md)|

| **Comece selecionando alguma das opções abaixo.** |
|--------------------|
|[**Refatoração do `update_progress()`**](#refatoração-do-update_progress---)|
|  **↳** [**Exemplo de uso**](#exemplo-de-uso---)|
|    **↳** [**Uso direto**](#uso-direto---)|
|    **↳** [**Usando o `global`**](#usando-o-global_var_funsh---)|
||
|[**Refatoração do `show_progress_dialog()`**](#refatoração-do-show_progress_dialog---)|
|  **↳** [**Padrão  de uso 1**](#padrão-de-uso-1---)|
|  **↳** [**Padrão  de uso 2**](#padrão-de-uso-2---)|
|  **↳** [**`steps-one-label`**](#steps-one-label---)|
|  **↳** [**`steps-multi-label`**](#steps-multi-label---)|
|  **↳** [**`wget`**](#wget---)|
|  **↳** [**`wget-labeled`**](#wget-labeled---)|
|  **↳** [**`extract`**](#extract---)|
|    **↳** [**Extraindo no diretório atual**](#extraindo-no-diretório-atual---)|
|    **↳** [**Extraindo em um diretório específico**](#extraindo-em-um-diretório-específico---)|
|  **↳** [**`check-packages`**](#check-packages---)|

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


Apesar de ser uma ferramenta autoexecutável, possui padrões de código que podem ser usadas fora dos instaladores, permitindo que os usuários possam instalar outras distribuições usando os padrões de código aqui presentes para facilitar e agilizar o processo de configuração e instalação.

# Refatoração do `update_progress()` [[ ↑ ]](#)
Função modular em bash para uma progresso impresso diretamente na tela do terminal, sem uso de caixas de dialogo.

```bash
update_progress() {
    local current_step=$1
    local total_steps=$2
    local percent=$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=$((percent * bar_length / 100))
    local empty_length=$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=$(printf "%${filled_length}s" | tr " " "=")
    empty_bar=$(printf "%${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

total_steps=2  # Número total de etapas que você quer monitorar
current_step=0

<comando> # uma etapa
((current_step++)) # adicionar após uma etapa
update_progress "$current_step" "$total_steps"; sleep 0.1 # adicionar após uma etapa
sleep 0.5

<comando> # uma etapa
((current_step++)) # adicionar após uma etapa
update_progress "$current_step" "$total_steps"; sleep 0.1 # adicionar após uma etapa
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt

```

## Exemplo de uso [[ ↑ ]](#)
Existe duas opções, uma será chamando o `update_progress()` pelo módulo `global` e a outra é usando diretamente no código.

### Uso direto [[ ↑ ]](#)
```bash
update_progress() {
    local current_step=$1
    local total_steps=$2
    local percent=$((current_step * 100 / total_steps))
    local bar_length=30
    local filled_length=$((percent * bar_length / 100))
    local empty_length=$((bar_length - filled_length))

    local filled_bar
    local empty_bar
    filled_bar=$(printf "%${filled_length}s" | tr " " "=")
    empty_bar=$(printf "%${empty_length}s" | tr " " " ")

    # AQUI ESTÁ O PULO DO GATO: força a saída para o terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

total_steps=5  # Número total de etapas que você quer monitorar
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
```

### Usando o `global` [[ ↑ ]](#)

```bash
source global

total_steps=5  # Número total de etapas que você quer monitorar
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Atualizando repositórios"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Instalando dialog"
sleep 0.5

echo    # quebra de linha ao final para não sobrepor prompt
```
> [!IMPORTANT]
> Troque o `source global` pelo caminho correto. Os caminhos padrões estarão documentados abaixo


# Refatoração do `show_progress_dialog()` [[ ↑ ]](#)
Função modular do `global` para usar a barra de progresso do `dialog` enquanto executa as tarefas. 

> [!IMPORTANT]
> No momento, o  `show_progress_dialog()` só funciona em distribuições baseadas no Debian. Será atualizado assim que o desenvolvedor deste repositório adicionar suporte a novas distribuições ou houver a colaboração de desenvolvedores externos.<br>

> [!NOTE]
> A ideia é que nenhum script precise implementar sua própria barra de progresso. Apenas chame `show_progress_dialog`

- Primeiro argumento: tipo (`steps-one-label`, `steps-multi-label`, `pid`, `pid-silent`, `wget`, `wget-labeled`, `extract`)
- Segundo: rótulo global (`<label>` )
    > Trocar pelo texto que será o título ou usar uma variável de idioma, tipo: `<label>` que se o sistema estiver em português do Brasil, irá retornar o valor `Em andamento...` onde for aparecer o texto.
- Terceiro: número de etapas
- Depois: pares "rótulo" comando

## Padrão de uso 1 [[ ↑ ]](#)
```bash
show_progress_dialog tipo <NÚMERO_DE_ETAPAS> \
"<label 1>" 'comando_1' \
"<label 2>" 'comando_2' \
```
## Padrão de uso 2 [[ ↑ ]](#)
```bash
show_progress_dialog tipo "<label> <NÚMERO_DE_ETAPAS>" 'comando'
```
<hr>

## `steps-one-label` [[ ↑ ]](#)
Usado quando você tem múltiplos comandos executados sequencialmente com um único rótulo.

```bash
show_progress_dialog steps-one-label "<label 1>" 5 \
"sudo apt update" \
"sudo apt full-upgrade -y" \
"sudo apt autoremove -y" \
"mkdir -p folder" \
"cp folder/arquivo.sh folder2/arquivo.sh" 
```

> [!NOTE]
> Lembre de usar o `DEBIAN_FRONTEND=noninteractive` no apt caso o pacote seja auto executável, como exemplo, o `tzdata`.

## `steps-multi-label` [[ ↑ ]](#)
Usado quando você tem múltiplos comandos executados sequencialmente com rótulos.

```bash
show_progress_dialog steps-multi-label 5 \
"<label 1>" "sudo apt update" \
"<label 1>" "sudo apt full-upgrade -y" \
"<label 2>" "sudo apt autoremove -y" \
"<label 3>" "mkdir -p folder" \
"<label 4>" "cp folder/arquivo.sh folder2/arquivo.sh"
```

> [!NOTE]
> Lembre de usar o `DEBIAN_FRONTEND=noninteractive` no apt caso o pacote seja auto executável, como exemplo, o `tzdata`.

## `wget` [[ ↑ ]](#)
Para baixar um arquivo ou mais com o mesmo rótulo.

```bash
show_progress_dialog wget "<label>" 1 -O "$HOME/arquivo.tar.xz" "<url_do_arquivo>"
```

## `wget-labeled` [[ ↑ ]](#)
Para baixar vários arquivos, cada um com seu próprio rótulo.

```bash
show_progress_dialog wget-labeled 2 \
"<label 1>" -O "caminho/script.sh" "${url1}" \
"<label 2>" -P "caminho" "${url2}"
```

## `extract` [[ ↑ ]](#)
Extrator de arquivos. Suporta as extensões `.tar.xz`, `.tar.gz`, `.tar.bz2`, `.tar`, `.zip`, `..xz`, `.gz`

### Extraindo no diretório atual [[ ↑ ]](#)
```bash
show_progress_dialog extract "<label>" "$HOME/rootfs.tar.xz"
```

### Extraindo em um diretório específico [[ ↑ ]](#)
```bash
show_progress_dialog extract "<label>" "/sdcard/fotos.zip" "$HOME/galeria"
```

## `check-packages` [[ ↑ ]](#)
Confirma se os pacotes escolhidos foram instalados ou não.

```bash
show_progress_dialog check-packages "<label>" pacote1 pacote2
```