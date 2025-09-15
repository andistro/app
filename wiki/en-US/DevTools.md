# DevTools ‐ Code Interface Standards

Although it is a self-executable tool, it has code standards that can be used outside the installers, allowing users to install other distributions using the code standards present here to facilitate and speed up the configuration and installation process.

## Refactoring `update_progress()`
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

### Usage example:
There are two options, one is calling `update_progress()` from the `global_var_fun.sh` module and the other is using it directly in the code.

**Direct use:**
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

**Using `global_var_fun.sh`:**

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
> Replace `source global_var_fun.sh` with the correct path. Default paths will be documented below.


## Refactoring `show_progress_dialog()`
Modular function from `global_var_fun.sh` to use the `dialog` progress bar while performing tasks.

> [!IMPORTANT]
> Currently, `show_progress_dialog()` only works on Debian-based distributions. It will be updated as soon as the developer of this repository adds support for new distributions or there is collaboration from external developers.<br>

> [!NOTE]
> The idea is that no script needs to implement its own progress bar. Just call `show_progress_dialog`

- First argument: type (`steps-one-label`, `steps-multi-label`, `pid`, `pid-silent`, `wget`, `wget-labeled`, `extract`)
- Second: global label (`<label>`)
    > Replace with the text that will be the title or use a language variable, like: `<label>` which, if the system is in Brazilian Portuguese, will return the value `Em andamento...` wherever the text appears.
- Third: number of steps
- Then: pairs "label" command

### Pattern 1:
```bash
show_progress_dialog type <NUMBER_OF_STEPS> \
"<label 1>" 'command_1' \
"<label 2>" 'command_2' \
```
### Pattern 2:
```bash
show_progress_dialog type "<label> <NUMBER_OF_STEPS>" 'command'
```
<hr>

#### `steps-one-label`
Used when you have multiple commands executed sequentially with a single label.

```bash
show_progress_dialog steps-one-label "<label 1>" 5 \
"sudo apt update" \
"sudo apt full-upgrade -y" \
"sudo apt autoremove -y" \
"mkdir -p folder" \
"cp folder/file.sh folder2/file.sh" 
```

> [!NOTE]
> Remember to use `DEBIAN_FRONTEND=noninteractive` in apt if the package is self-executable, such as `tzdata`.

#### `steps-multi-label`
Used when you have multiple commands executed sequentially with labels.

```bash
show_progress_dialog steps-multi-label 5 \
"<label 1>" "sudo apt update" \
"<label 1>" "sudo apt full-upgrade -y" \
"<label 2>" "sudo apt autoremove -y" \
"<label 3>" "mkdir -p folder" \
"<label 4>" "cp folder/file.sh folder2/file.sh"
```

> [!NOTE]
> Remember to use `DEBIAN_FRONTEND=noninteractive` in apt if the package is self-executable, such as `tzdata`.

#### `wget`
To download one or more files with the same label.

```bash
show_progress_dialog wget "<label>" 1 -O "$HOME/file.tar.xz" "<file_url>"
```

#### `wget-labeled`
To download multiple files, each with its own label.

```bash
show_progress_dialog wget-labeled 2 \
"<label 1>" -O "path/script.sh" "${url1}" \
"<label 2>" -P "path" "${url2}"
```

#### `extract`
File extractor. Supports the extensions `.tar.xz`, `.tar.gz`, `.tar.bz2`, `.tar`, `.zip`, `.xz`, `.gz`

**Extracting in the current directory:**
```bash
show_progress_dialog extract "<label>" "$HOME/rootfs.tar.xz"
```

**Extracting a .zip in a specific directory:**
```bash
show_progress_dialog extract "<label>" "/sdcard/photos.zip" "$HOME/gallery"
```

#### `check-packages`
Confirms whether the selected packages were installed or not.

```bash
show_progress_dialog check-packages "<label>"