<!--
📄  Padrões de interface de código
-->
# Padrões de interface
> [!IMPORTANT]
> Exige a chamada do `global_var_fun.sh` usando o `source`.

## Refatoração do `update_progress()`
Função mobular em bash para uma progresso impresso diretamente na tela do terminal, sem uso de caixas de dialogo.

#### Padrão:
```bash
total_steps=1  # Número total de etapas que você quer monitorar
current_step=0
{
    <comando> # uma etapa
    ((current_step++)) # adicionar após uma etapa
    update_progress "$current_step" "$total_steps"; sleep 0.1 # adicionar após uma etapa 
}

```

#### Exemplo de uso:
Será criado uma pasta em `$HOME` chamada `etapa`, solicitado uma atualização de repositório com o `apt update` irá verificar se o pacote `wget` está instalado, baixar caso não estaja e baixar um arquivo usando o `wget`. Serão 4 processos/etapa.

```bash
total_steps=4  # Número total de etapas que você quer monitorar
current_step=0 

{
    # Etapa 1 =====================================================
    mkdir -p $HOME/etapa
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1
    # Fim da etapa 1 ==============================================

    # Etapa 2 =====================================================
    apt update
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1
    # Fim da etapa 2 ==============================================

    # Etapa 3 =====================================================
    if ! dpkg -l | grep -qw wget; then # verifica se o wget está instalado
        apt install wget -y # caso o wget não esteja instalado, este comando será executado
    fi
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1
    # Fim da etapa 3 ==============================================

    # Etapa 4 =====================================================
    wget url.sh # baixa o arquivo urs.sh
    ((current_step++))
    update_progress "$current_step" "$total_steps"; sleep 0.1
    # Fim da etapa 4 ==============================================
}

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

| Tipo | Ideal para | Comandos múltiplos | Oculta saída | Fluidez |
|------|------------|--------------------|--------------|---------|
| `steps` | Vários comandos genéricos | ✅ | ❌ | Média |
| `apt-labeled` | Vários comandos `apt` | ✅ | ✅ | Média |
| `pid` | Um único comando visível | ❌ | ❌ | Alta |
| `pid-silent` | Um comando longo e oculto | ❌ | ✅ | Alta |
| `wget` | Um único download | ❌ | ✅ | Média |
| `wget-labeled` | Múltiplos downloads | ✅ | ✅ | Média |
| `extract` | Extração de arquivos (`.tar`, `.zip`, `.tar.xz`, `.tar.gz`, `.gz`) | ❌ | ✅ | Média |

### `steps`
Usado quando você tem múltiplos comandos executados sequencialmente com rótulos.

```bash
show_progress_dialog steps 5 \
"<label 1>" "sudo apt update" \
"<label 1>" "sudo apt full-upgrade -y" \
"<label 2>" "sudo apt autoremove -y" \
"<label 3>" "mkdir -p folder" \
"<label 4>" "cp folder/arquivo.sh folder2/arquivo.sh" \
```


### `apt-labeled`
Especializado para comandos `apt`, com múltiplos comandos já com `sudo`.

```bash
show_progress_dialog apt-labeled 3 \
"<label 1>" 'apt update' \
"<label 2>" 'sudo apt full-upgrade -y' \
"<label 3>" 'apt clean'
```
- Você mesmo insere o `sudo` diretamente no comando.
- Simples e ideal para listas de tarefas do APT.

### `pid`
Executa um único comando com barra de progresso simulada. Ideal para operações demoradas.
```bash
show_progress_dialog pid "<label>" "dpkg-reconfigure locales"
```
- "Comando visível".
- Mostra barra fluida durante execução.

### `pid-silent`
Igual ao `pid`, mas suprime a saída para não mostrar arquivos sendo baixados. Ideal para `debootstrap`.

```bash
show_progress_dialog pid-silent "${label_debian_download}" \
debootstrap --arch="arch" "codinome" "caminho" url
```
- Executa o comando em background.
- A barra vai subindo suavemente, sem mostrar o progresso real.

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
"<label 1>" -O script.sh "${url1}" \
"<label 2>" -O pacote.deb "${url2}"
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
