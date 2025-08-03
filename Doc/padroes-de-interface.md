<!--
📄  Padrões de interface de código
-->
# Padrões de interface
> [!IMPORTANT]
> Exige a chamada do `global_var_fun.sh` usando o `source`.

## Refatoração do `update_progress()`
Função mobular em bash para uma progresso impresso diretamente na tela do terminal, sem uso de caixas de dialogo.

### `global_var_fun.sh`
Dentro do do módulo global existe um código que irá funcionar onde ele for chamado, o código é:

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
```

#### Padrão:
```bash
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

#### Exemplo de uso:
Será criado uma pasta em `$HOME` chamada `etapa`, solicitado uma atualização de repositório com o `apt update` irá verificar se o pacote `wget` está instalado, baixar caso não estaja e baixar um arquivo usando o `wget`. Serão 4 processos/etapa.

```bash
source "/usr/local/bin/global_var_fun.sh" # trocar pelo real caminho que o global_va_fun.sh está
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

## Refatoração do `show_progress_dialog()`
Função modular bash para usar a barra de progresso do `dialog`. 

> [!NOTE]
> A ideia é que nenhum script precise implementar sua própria barra de progresso. Apenas chame `show_progress_dialog`

- Primeiro argumento: tipo (`steps`, `apt-labeled`, `pid`, `pid-silent`, `wget`, `wget-labeled`, `extract`)
- Segundo: rótulo global (`"${label_progress}"`/ `<label>` )
    > Trocar pelo texto que será o título ou usar uma variável de idioma, tipo: `${label_progress}` que se o sistema estiver em português do Brasil, irá retornar o valor `Em andamento...` onde for aparecer o texto.
- Terceiro: número de etapas
- Depois: pares "rótulo" comando

#### Padrão 1:
```bash
show_progress_dialog tipo <NÚMERO_DE_ETAPAS> \
"<label 1>" 'comando_1' \
"<label 2>" 'comando_2' \
```
#### Padrão 2:
```bash
show_progress_dialog tipo <NÚMERO_DE_ETAPAS> "<label>" 'comando'
```

| Tipo | Ideal para | Comandos múltiplos | Fluidez |
|------|------------|--------------------|--------------|---------|
| `steps-one-label` | Vários comandos genéricos | ✅ | Média |
| `steps-multi-label` | Vários comandos genéricos | ✅ | Média |
| `wget` | Um único download | ❌ | Média |
| `wget-labeled` | Múltiplos downloads | ✅ | Média |
| `extract` | Extração de arquivos (`.tar`, `.zip`, `.tar.xz`, `.tar.gz`, `.gz`) | ❌  | Média |

### `steps-one-label`
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

### `steps-multi-label`
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

### `wget`
Para baixar um único arquivo com rótulo.

```bash
show_progress_dialog wget "${label_download}" \
-O "$HOME/arquivo.tar.xz" "${url_do_arquivo}"
```

### `wget-labeled`
Para baixar vários arquivos, cada um com seu próprio rótulo.

```bash
show_progress_dialog wget-labeled 2 \
"<label 1>" -O "caminho/script.sh" "${url1}" \
"<label 2>" -P "caminho" "${url2}"
```
- Primeiro argumento: número de arquivos.
- Depois: pares "rótulo" argumentos do wget.

### `extract`
Extrator de arquivos

#### Extraindo no diretório atual:
```bash
show_progress_dialog extract "<label>" "$HOME/rootfs.tar.xz"
```

#### Extraindo um .zip em um diretório específico:
```bash
show_progress_dialog extract "<label>" "/sdcard/fotos.zip" "$HOME/galeria"
```

- A extração é silenciosa (`>/dev/null 2>&1`) para não atrapalhar o `dialog --gauge`.
- A barra de progresso sobe gradualmente até 95%, e só completa quando o processo termina.
- Usa detecção automática baseada na extensão do arquivo.
- Internamente, ele é implementado com `pid`, então mantém a fluidez.
- É silencioso e serve para qualquer tipo de descompressão básica.
