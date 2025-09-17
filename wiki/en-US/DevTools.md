# DevTools ‐ Code Interface Standards

<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="Bandeira dos Estados Unidos"> ![Translated by the Perplexity Comet assistant](https://img.shields.io/badge/Translated_by_Perplexity_Comet_Assistant-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZmZmZmZmIj48cGF0aCBkPSJtNDc2LTgwIDE4Mi00ODBoODRMOTI0LTgwaC04NGwtNDMtMTIySDYwM0w1NjAtODBoLTg0Wk0xNjAtMjAwbC01Ni01NiAyMDItMjAycS0zNS0zNS02My41LTgwVDE5MC02NDBoODRxMjAgMzkgNDAgNjh0NDggNThxMzMtMzMgNjguNS05Mi41VDQ4NC03MjBINDB2LTgwaDI4MHYtODBoODB2ODBoMjgwdjgwSDU2NHEtMjEgNzItNjMgMTQ4dC04MyAxMTZsOTYgOTgtMzAgODItMTIyLTEyNS0yMDIgMjAxWm00NjgtNzJoMTQ0bC03Mi0yMDQtNzIgMjA0WiIvPjwvc3ZnPg==)
![ForYou](https://img.shields.io/badge/Created_with_❤️-gray)
![Android](https://img.shields.io/badge/Android-gray?logo=android)
![Termux](https://img.shields.io/badge/Termux-gray?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0OCA0OCI+CgogICAgPCEtLSBTY3JlZW4gYW5kIGJvcmRlci4gLS0+CiAgICA8cGF0aCBmaWxsPSIjMDAwIgogICAgICAgICAgc3Ryb2tlPSIjQkZDQkNEIgogICAgICAgICAgc3Ryb2tlLXdpZHRoPSIyIgogICAgICAgICAgZD0iTTksNgogICAgICAgICAgICAgbDMwLDAKICAgICAgICAgICAgIHEzIDAsMyAzCiAgICAgICAgICAgICBsMCwzMAogICAgICAgICAgICAgcTAgMywgLTMgMwogICAgICAgICAgICAgbC0zMCwwCiAgICAgICAgICAgICBxLTMgMCwgLTMtMwogICAgICAgICAgICAgbDAgLTMwCiAgICAgICAgICAgICBxMCAtMywgMyAtMyIKICAgIC8+CgogICAgPCEtLSBCbG9jayBjdXJzb3IuIC0tPgogICAgPHBhdGggZmlsbD0iI0ZGRiIKICAgICAgICAgIGQ9Ik0xNCwxNAogICAgICAgICAgICAgbDUsMAogICAgICAgICAgICAgbDAsMTAKICAgICAgICAgICAgIGwtNSwwIgogICAgLz4KCjwvc3ZnPgo=)


|📄|Documentation|
|-|-|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="United States Flag">|[English of United States (en-US)](/wiki/en-US/README.md)|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px" alt="Brazil Flag">|[Brazilian Portuguese (pt-BR)](/wiki/pt-BR/README.md)|


| **Start by selecting one of the options below.** |
|--------------------|
|[**Refactoring `update_progress()`**](#refactoring-update_progress---)|
|  **↳** [**Usage example**](#usage-example---)|
|    **↳** [**Direct use**](#direct-use---)|
|    **↳** [**Using `global_var_fun.sh`**](#using-global_var_funsh---)|
||
|[**Refactoring `show_progress_dialog()`**](#refactoring-show_progress_dialog---)|
|  **↳** [**Usage pattern 1**](#usage-pattern-1---)|
|  **↳** [**Usage pattern 2**](#usage-pattern-2---)|
|  **↳** [**`steps-one-label`**](#steps-one-label---)|
|  **↳** [**`steps-multi-label`**](#steps-multi-label---)|
|  **↳** [**`wget`**](#wget---)|
|  **↳** [**`wget-labeled`**](#wget-labeled---)|
|  **↳** [**`extract`**](#extract---)|
|    **↳** [**Extracting in the current directory**](#extracting-in-the-current-directory---)|
|    **↳** [**Extracting in a specific directory**](#extracting-in-a-specific-directory---)|
|  **↳** [**`check-packages`**](#check-packages---)|

<!--h1
|[** **]()|
h1 alt
|**↳** [** **]()|
h2
|  **↳** [** **]()|
h3
|    **↳** [** **]()|
h4
|      **↳** [** **]()|
-->

Despite being a self-executable tool, it has code standards that can be used outside the installers, allowing users to install other distributions using the code standards present here to facilitate and speed up the configuration and installation process.

# Refactoring `update_progress()` [[ ↑ ]](#)

Modular bash function for progress printed directly to the terminal screen, without using dialog boxes.

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
    # HERE'S THE TRICK: forces output to the terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

total_steps=2  # Total number of steps you want to monitor
current_step=0

<command> # one step
((current_step++)) # add after a step
update_progress "$current_step" "$total_steps"; sleep 0.1 # add after a step
sleep 0.5

<command> # one step
((current_step++)) # add after a step
update_progress "$current_step" "$total_steps"; sleep 0.1 # add after a step
sleep 0.5

echo    # line break at the end so as not to overwrite the prompt
```

## Usage example [[ ↑ ]](#)

There are two options, one is calling `update_progress()` from the `global_var_fun.sh` module and the other is using it directly in the code.

### Direct use [[ ↑ ]](#)

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
    # HERE'S THE TRICK: forces output to the terminal
    printf "\r[%s%s] %3d%%" "$filled_bar" "$empty_bar" "$percent" > /dev/tty
}

total_steps=5  # Total number of steps you want to monitor
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Updating repositories"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Installing dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing dialog"
sleep 0.5

echo    # line break at the end so as not to overwrite the prompt
```

### Using `global_var_fun.sh`:

```bash
source global_var_fun.sh

total_steps=5  # Total number of steps you want to monitor
current_step=0

apt update -qq -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Updating repositories"
sleep 0.5

if ! dpkg -l | grep -qw sudo; then
    apt-get install sudo -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing sudo"
sleep 0.5

sudo apt autoremove --purge whiptail -y > /dev/null 2>&1
((current_step++))
update_progress "$current_step" "$total_steps" "Installing dialog"
sleep 0.5

if ! dpkg -l | grep -qw wget; then
    apt-get install wget -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing wget"
sleep 0.5

if ! dpkg -l | grep -qw dialog; then
    apt-get install dialog -y > /dev/null 2>&1
fi
((current_step++))
update_progress "$current_step" "$total_steps" "Installing dialog"
sleep 0.5

echo    # line break at the end so as not to overwrite the prompt
```

> [!IMPORTANT]
> Replace `source global_var_fun.sh` with the correct path. Default paths will be documented below

# Refactoring `show_progress_dialog()` [[ ↑ ]](#)

Modular function from `global_var_fun.sh` to use the `dialog` progress bar while executing tasks.

> [!IMPORTANT]
> Currently, `show_progress_dialog()` only works on Debian-based distributions. It will be updated as soon as the developer of this repository adds support for new distributions or there is collaboration from external developers.

> [!NOTE]
> The idea is that no script needs to implement its own progress bar. Just call `show_progress_dialog`

- First argument: type (`steps-one-label`, `steps-multi-label`, `pid`, `pid-silent`, `wget`, `wget-labeled`, `extract`)
- Second: global label (`<label>`)
    > Replace with the text that will be the title or use a language variable, like: `<label>` which, if the system is in Brazilian Portuguese, will return the value `In progress...` wherever the text appears.
- Third: number of steps
- Then: pairs "label" command

## Usage pattern 1 [[ ↑ ]](#)

```bash
show_progress_dialog type <n> \
"<label>" 'command_1' \
"<label>" 'command_2' \
```

## Usage pattern 2 [[ ↑ ]](#)

```bash
show_progress_dialog type "<n>" 'command'
```

## `steps-one-label` [[ ↑ ]](#)

Used when you have multiple commands executed sequentially with a single label.

```bash
show_progress_dialog steps-one-label "<label>" 5 \
"sudo apt update" \
"sudo apt full-upgrade -y" \
"sudo apt autoremove -y" \
"mkdir -p folder" \
"cp folder/file.sh folder2/file.sh" 
```

> [!NOTE]
> Remember to use `DEBIAN_FRONTEND=noninteractive` in apt if the package is self-executable, such as `tzdata`.

## `steps-multi-label` [[ ↑ ]](#)

Used when you have multiple commands executed sequentially with labels.

```bash
show_progress_dialog steps-multi-label 5 \
"<label>" "sudo apt update" \
"<label>" "sudo apt full-upgrade -y" \
"<label>" "sudo apt autoremove -y" \
"<label>" "mkdir -p folder" \
"<label>" "cp folder/file.sh folder2/file.sh"
```

> [!NOTE]
> Remember to use `DEBIAN_FRONTEND=noninteractive` in apt if the package is self-executable, such as `tzdata`.

## `wget` [[ ↑ ]](#)

To download one or more files with the same label.

```bash
show_progress_dialog wget "<label>" 1 -O "$HOME/file.tar.xz" "<file_url>"
```

## `wget-labeled` [[ ↑ ]](#)

To download multiple files, each with its own label.

```bash
show_progress_dialog wget-labeled 2 \
"<label>" -O "path/script.sh" "${url1}" \
"<label>" -P "path" "${url2}"
```

## `extract` [[ ↑ ]](#)

File extractor. Supports the extensions `.tar.xz`, `.tar.gz`, `.tar.bz2`, `.tar`, `.zip`, `.xz`, `.gz`

### Extracting in the current directory [[ ↑ ]](#)

```bash
show_progress_dialog extract "<label>" "$HOME/rootfs.tar.xz"
```

### Extracting in a specific directory [[ ↑ ]](#)

```bash
show_progress_dialog extract "<label>" "/sdcard/photos.zip" "$HOME/gallery"
```

## `check-packages` [[ ↑ ]](#)

Confirms whether the selected packages were installed or not.

```bash
show_progress_dialog check-packages "<label>" package1 package2
```