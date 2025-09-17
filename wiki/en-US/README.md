# 📄 Documentation

<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="Bandeira dos Estados Unidos"> ![Translated by GitHub Copilot](https://img.shields.io/badge/Translated_by_GitHub_Copilot-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZmZmZmZmIj48cGF0aCBkPSJtNDc2LTgwIDE4Mi00ODBoODRMOTI0LTgwaC04NGwtNDMtMTIySDYwM0w1NjAtODBoLTg0Wk0xNjAtMjAwbC01Ni01NiAyMDItMjAycS0zNS0zNS02My41LTgwVDE5MC02NDBoODRxMjAgMzkgNDAgNjh0NDggNThxMzMtMzMgNjguNS05Mi41VDQ4NC03MjBINDB2LTgwaDI4MHYtODBoODB2ODBoMjgwdjgwSDU2NHEtMjEgNzItNjMgMTQ4dC04MyAxMTZsOTYgOTgtMzAgODItMTIyLTEyNS0yMDIgMjAxWm00NjgtNzJoMTQ0bC03Mi0yMDQtNzIgMjA0WiIvPjwvc3ZnPg==)
![ForYou](https://img.shields.io/badge/Created_with_❤️-gray)
![Android](https://img.shields.io/badge/Android-gray?logo=android)
![Termux](https://img.shields.io/badge/Termux-gray?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0OCA0OCI+CgogICAgPCEtLSBTY3JlZW4gYW5kIGJvcmRlci4gLS0+CiAgICA8cGF0aCBmaWxsPSIjMDAwIgogICAgICAgICAgc3Ryb2tlPSIjQkZDQkNEIgogICAgICAgICAgc3Ryb2tlLXdpZHRoPSIyIgogICAgICAgICAgZD0iTTksNgogICAgICAgICAgICAgbDMwLDAKICAgICAgICAgICAgIHEzIDAsMyAzCiAgICAgICAgICAgICBsMCwzMAogICAgICAgICAgICAgcTAgMywgLTMgMwogICAgICAgICAgICAgbC0zMCwwCiAgICAgICAgICAgICBxLTMgMCwgLTMtMwogICAgICAgICAgICAgbDAgLTMwCiAgICAgICAgICAgICBxMCAtMywgMyAtMyIKICAgIC8+CgogICAgPCEtLSBCbG9jayBjdXJzb3IuIC0tPgogICAgPHBhdGggZmlsbD0iI0ZGRiIKICAgICAgICAgIGQ9Ik0xNCwxNAogICAgICAgICAgICAgbDUsMAogICAgICAgICAgICAgbDAsMTAKICAgICAgICAgICAgIGwtNSwwIgogICAgLz4KCjwvc3ZnPgo=)


| 📄 |Documentation|
|-|-|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1e7_1f1f7.svg" width="22px" alt="Brazil Flag">|[Brazilian Portuguese (pt-BR)](/wiki/pt-BR/README.md)|
|<img src="https://raw.githubusercontent.com/andistro/app/refs/heads/main/Doc/assets/emojis/emoji_u1f1fa_1f1f8.svg" width="22px" alt="United States Flag">|[English of United States (en-US)](/wiki/en-US/README.md)|

| **Start by selecting one of the options below.** |
|--------------------|
|[**Requirements**](#Requirements)|
||
|[**Required installations**](#Required-installations)|
||
|[**Starting the system installation**](#Starting-the-system-installation)|
|  **↳** [**Downloading the installer**](#downloading-the-installer)|
||
|[**Troubleshooting**](/wiki/en-US/troubleshooting.md)|
||
|[**DevTools ‐ Code interface standards**](/wiki/en-US/DevTools.md)|


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

<!-- **Install popular distributions inside the Android environment without root.** -->
**Install Linux distributions inside the Android environment without root.**

This is a project that allows you to install Linux distributions, such as Ubuntu and Debian, on Android devices without the need for root. The system runs inside the Termux environment and uses VNC to provide a complete graphical interface, without modifying Android settings.

To ensure trust and security, no system is hosted in the repository—all are downloaded directly from the official distribution websites. The installer code is completely open for verification.


> [!NOTE]
> This installation script was made for Android devices with ARM64 architecture.

> [!IMPORTANT]
> The entire system will run inside Termux and, since there is no root, it will not modify Android settings. <br>
> To ensure the trust of this project, no system is hosted here; all are downloaded directly from the official operating system website.<br>
> The installer code is fully open so you can check every file.<br>

>[!WARNING]
> This installer is tested several times and uses official tools to work and ensure data security, but if you install any unknown file containing malware, it is not guaranteed that it will not affect the device's internal memory. Even if the malware runs only inside the virtual machine, the system can read and modify files in the internal memory. It just cannot modify protected system files, such as those in the `Android/data` folder.

# Requirements

|||Recommended|Minimum|Not supported|
|-|-|-|-|-|
|![Supported Architectures](https://img.shields.io/badge/-gray?logo=arm&logoColor=white)|Architectures| ![Arm](https://img.shields.io/badge/ARM64-0091BD) | ![Arm](https://img.shields.io/badge/ARMHF-0091BD) |![x86_64](https://img.shields.io/badge/x86__64-gray)|
|![Storage](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJNMTIwLTE2MHYtMTYwaDcyMHYxNjBIMTIwWm04MC00MGg4MHYtODBoLTgwdjgwWm0tODAtNDQwdi0xNjBoNzIwdjE2MEgxMjBabTgwLTQwaDgwdi04MGgtODB2ODBabS04MCAyODB2LTE2MGg3MjB2MTYwSDEyMFptODAtNDBoODB2LTgwaC04MHY4MFoiLz48L3N2Zz4=)|Free storage space|![64GB](https://img.shields.io/badge/Above_64GB-FBBC04)|![40GB](https://img.shields.io/badge/40GB-gray)|
|![RAM](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJNMjQwLTM2MGg4MHYtMjQwaC04MHYyNDBabTIwMCAwaDgwdi0yNDBoLTgwdjI0MFptMjAwIDBoODB2LTI0MGgtODB2MjQwWm0tNDgwIDgwaDY0MHYtNDAwSDE2MHY0MDBabTAgMHYtNDAwIDQwMFptNDAgMTYwdi04MGgtNDBxLTMzIDAtNTYuNS0yMy41VDgwLTI4MHYtNDAwcTAtMzMgMjMuNS01Ni41VDE2MC03NjBoNDB2LTgwaDgwdjgwaDE2MHYtODBoODB2ODBoMTYwdi04MGg4MHY4MGg0MHEzMyAwIDU2LjUgMjMuNVQ4ODAtNjgwdjQwMHEwIDMzLTIzLjUgNTYuNVQ4MDAtMjAwaC00MHY4MGgtODB2LTgwSDUyMHY4MGgtODB2LTgwSDI4MHY4MGgtODBaIi8+PC9zdmc+)|RAM|![](https://img.shields.io/badge/Above_6GB-orange)|
|![Android Version](https://img.shields.io/badge/-gray?logo=android&logoColor=white)|Android|![Android 10+](https://img.shields.io/badge/Android_10+-073042)|
|![Root](https://img.shields.io/badge/-gray?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAtOTYwIDk2MCA5NjAiIHdpZHRoPSIyNHB4IiBmaWxsPSIjZTNlM2UzIj48cGF0aCBkPSJtMjQwLTE2MCA0MC0xNjBIMTIwbDIwLTgwaDE2MGw0MC0xNjBIMTgwbDIwLTgwaDE2MGw0MC0xNjBoODBsLTQwIDE2MGgxNjBsNDAtMTYwaDgwbC00MCAxNjBoMTYwbC0yMCA4MEg2NjBsLTQwIDE2MGgxNjBsLTIwIDgwSDYwMGwtNDAgMTYwaC04MGw0MC0xNjBIMzYwbC00MCAxNjBoLTgwWm0xNDAtMjQwaDE2MGw0MC0xNjBINDIwbC00MCAxNjBaIi8+PC9zdmc+)|Root|![Not required](https://img.shields.io/badge/Not_required-red)|
|![ADB](https://img.shields.io/badge/-gray?logo=android&logoColor=white)|ADB|![May be required](https://img.shields.io/badge/Required_on_Android_12,_13_and_14-073042)|



|||Supported|With issues|In testing|
|-|-|-|-|-|
||Systems| ![Debian](https://img.shields.io/badge/Debian-13-red?logo=debian&logoColor=white) <br>![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu&logoColor=white)|
||Graphical interface| ![XFCE](https://img.shields.io/badge/XFCE-2284F2?logo=xfce&logoColor=white)|

> [!CAUTION]
> Using the system on a weaker device may cause overload and damage internal components due to high processing demand.

# Required installations

For everything to work correctly, you need to install **Termux**, **Andronix**, and **AVNC**. Termux will install and run the distribution locally, Andronix will provide the distribution installation script, and AVNC will allow you to view and use the Ubuntu graphical interface.
|**Where to download**|
|------|
||
|**Termux**|
|<a href="https://github.com/termux/termux-app/releases" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-github.png" alt="Download from GitHub"></a> <a href="https://f-droid.org/pt_BR/packages/com.termux/" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-fdroid.png" alt="Download from F-Droid"></a>|
|**AVNC**|
|<a href="https://github.com/gujjwal00/avnc/releases" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-github.png" alt="Download from GitHub"></a><a href="https://f-droid.org/pt_BR/packages/com.gaurav.avnc/" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-fdroid.png" alt="Download from F-Droid"></a> <a href="https://play.google.com/store/apps/details?id=com.gaurav.avnc" target="_blank"><img width="256px" src="https://raw.githubusercontent.com/andistro/app/main/Doc/assets/badges/get-it-on-google-play.png" alt="Download from Google Play Store"></a>|
> [!WARNING]
> The Termux from Google Play Store is outdated and no longer has official support.

# Enable Android developer mode

> [!CAUTION]
> This is a risky area. All settings listed here are system-level modifications. If you don't know what you're doing, find out what each thing does and how to revert the situation before running the commands. <br>
> In some cases, it will be necessary to restore the device to factory settings; in other cases, you may need to reinstall the operating system on the device. <br>
> `adb` processes may change depending on the device and Android version.

> [!NOTE]
> Steps may change depending on how the device manufacturer chose to position the function.

1. Open system settings;
2. Go to the "about phone" option;
3. Access system information;
4. Tap 5 or more times on the "build number" option until the unlock password prompt appears.
5. Enter the password you use to unlock the device;
6. A toast alert will appear stating that developer mode is active;
7. Go back to the beginning of system settings.

# Fixing the forced system stop issue in Termux ‐ `[Process completed (signal 9) ‐ press Enter]`

## About the issue

> [!CAUTION]
> This is a risky area. All settings listed here are system-level modifications. If you don't know what you're doing, find out what each thing does and how to revert the situation before running the commands. <br>
> In some cases, it will be necessary to restore the device to factory settings; in other cases, you may need to reinstall the operating system on the device. <br>
> `adb` processes may change depending on the device and Android version.


Since Android 12, Termux and other apps have received restrictions on CPU usage. This is better explained by [Agnostic-apollo in a documentation called "Phantom, Cached And Empty Processes"](https://github.com/agnostic-apollo/Android-Docs/blob/master/en/docs/apps/processes/phantom-cached-and-empty-processes.md). In short, Android is limiting the performance of any app that tries to excessively use the CPU, and because of this restriction, Termux—the app used to install the Linux distribution inside Android—shows the error `[Process completed (signal 9) - press Enter]` and forces the system to stop, making the user restart the app and the local server.

Even with this restriction, there are alternatives to disable it, but you will need access to the developer options on your phone. One way is to use Termux itself, adb, and Wi-Fi debugging from the developer options to disable `settings_enable_monitor_phantom_procs`

> [!NOTE]
> On Samsung's OneUI 7, you need to disable the auto blocker in `settings > security and privacy > auto blocker`. Otherwise, you won't be able to enable Wi-Fi debugging and the system will create restriction barriers.

<br><br>

## Disabling Phantom Process on Android 12 and 13

### Disable phantom process monitor via `feature flags`
> [!NOTE]
> Not all devices will have this option.
1. Enable developer options. [Tutorial here](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Go to developer options. Usually the last option in your device's settings;
2. Look for the `feature flags` option;
3. Disable the `settings_enable_monitor_phantom_procs` option;
<br><br>

### Disable phantom process monitor via `adb`
#### Allow Termux to use `adb`

> [!CAUTION]
> You will need to use `adb`. Pay attention, as `adb` can make aggressive changes to the Android system, and in some cases, you may need to restore the device to factory settings or even reinstall the system if you remove something essential for operation. What is described here has already been documented on several portals on the internet, and each manufacturer may create different restrictions on the command.

> [!WARNING]
> If you have never used or don't know `adb`, this documentation will not provide in-depth details about the tool, so I recommend you learn more from other pages, especially Android's.
> - [Android Debug Bridge (adb)](https://developer.android.com/tools/adb)

> [!NOTE]
> `adb` is already installed on Android, so you don't need to install it. For this process, which aims to solve the `process 9` issue, you will need an app that can have developer permissions and execute the necessary commands to disable phantom processes. In this documentation, Termux will be used, but depending on the device, you may need a computer.


1. Enable developer options. [Tutorial here](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Go to developer options. Usually the last option in your device's settings;
3. Look for the `Wi-Fi debugging` option, open and enable it;
4. Open Termux in split-screen mode;
    <details><summary>Example</summary><img height="500px" margin="10px" alt="image" src="https://github.com/user-attachments/assets/f1bfa6b4-a56b-40da-967e-346e21194578" /><br><a href="https://github.com/user-attachments/assets/f1bfa6b4-a56b-40da-967e-346e21194578" target="_blank">Expand image</a><br><br><img height="500px" alt="image" src="https://github.com/user-attachments/assets/e2ae59c0-fdfd-45ea-a93e-1659e486ed18"/><br><a href="https://github.com/user-attachments/assets/e2ae59c0-fdfd-45ea-a93e-1659e486ed18" target="_blank">Expand image</a></details>
> [!TIP]
> The order of the windows is not important; what matters is that both apps are in split-screen mode as shown in the example.

5. In Termux, install the `android-tools` package:
```shell
pkg install android-tools -y
```
6. In Wi-Fi debugging, click the option `pair device with pairing code` and run the command below in Termux and press `enter` to confirm, but first, pay attention to the conditions below:
```shell
adb pair <IP Address and port> <wireless pairing code>
# Example: 
# adb pair localhost:12345 123456
# adb pair 192.168.1.2:12345 123456
```
> [!NOTE]
> Replace `<IP Address and port>` with the link that appears below `IP address and port`. <br>
> Replace <wireless pairing code> with the code that appears in `Wi-Fi pairing code.`

> [!IMPORTANT]
> The port and pairing code may change when the device screen turns off or when you leave the app, so Termux should be opened in split-screen mode so the code is not reset before pairing.<br>
> The IP address may be `localhost`, which is recommended because if the Wi-Fi network is restarted, the IP address may change and consequently, `adb pair` will not work because it can't find the link.

> [!NOTE]
> When paired, a success message will appear in English

8. Check the list of paired devices using the command `adb devices`. If the message `List of devices attached` appears and no other message listing paired devices, you should pair Termux to run `adb` commands.
9. Run the command `adb connect` to reconnect Termux to adb via Wi-Fi
```shell
adb connect <IP Address and port>
```
#### Disabling phantom process monitor via Termux

> [!CAUTION]
> As mentioned, all `adb` commands on this page modify the system and may cause problems that can only be resolved by restoring to factory settings and may even be irreversible. Be careful; if you continue, it is at your own risk.

> [!NOTE]
> Not all devices can use `adb` directly on the device and may depend on a computer with Windows, macOS, or Linux.

1. Check paired devices using the command below. Make sure Termux is paired to continue the next steps.
```shell
adb devices
```
>[!NOTE]
> If Termux is not connected, follow steps 8, 9, and 10 of the step: [give `adb` permissions to Termux](#dar-as-permissões-de-adb-para-o-termux).

2. Run the following commands:
>[!NOTE]
> Remember to press `enter` after running any of the codes.

```shell
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
```
```shell
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
```
<!-- this command will show executed: adb shell "/system/bin/device_config list activity_manager" -->

```shell
adb shell settings put global settings_enable_monitor_phantom_procs false
```
Done. You don't need to restart the device, and if you want, you can disable developer options so it doesn't interfere with other apps that don't work when the option is enabled, such as government and banking apps.

>[!NOTE]
> To check if it worked, run the commands below one by one
```bash 
adb shell "/system/bin/dumpsys activity settings | grep max_phantom_processes"
```
```bash
adb shell "/system/bin/device_config get activity_manager max_phantom_processes"
```
>[!NOTE]
> It is expected to return the value `2147483647`


<br><br><br>

## Disabling Phantom Process on Android 14 and 15
1. Enable developer options. [Tutorial here](https://github.com/andistro/app/wiki/3.-Ativar-o-modo-desenvolvedor-do-Android);
2. Go to developer options. Usually the last option in your device's settings;
3. Look for `disable secondary process restrictions` and enable the option.

>[!NOTE]
> Unlike `adb`, this requires that `developer options` remain enabled.


# Starting the system installation

## Downloading the installer

The first and most important step is to install the apps for the installer to work. [They are listed here](https://github.com/andistro/app/wiki/Instala%C3%A7%C3%B5es-necess%C3%A1rias).

After Termux has been installed and started on the device, now it's time to download the file that will make the system work on your phone. Follow the steps below:

1. Type or copy and paste the code below into [Termux](intent://#Intent;package=com.termux;scheme=termux;end) and then press enter (↵) to download the file:
```bash
curl -O https://raw.githubusercontent.com/andistro/app/main/andistro
```

2. Type or copy and paste the code below into Termux to give the file permission to run:
```bash
chmod +x andistro
```
3. Type or copy and paste the code below into Termux to start the file:
```bash
bash andistro -u
```
> [!NOTE]
> The `-u` command forces the update and configuration of the tool. If you don't use it, the tool may have execution problems.


> [!NOTE]
> You can use this command directly if you don't want to run one command at a time
> ```bash
> curl -O https://raw.githubusercontent.com/andistro/app/main/andistro && chmod +x andistro && bash andistro -u
> ```

4. The file will finish the necessary configurations and show an explanation of how to install, uninstall, and start the systems.

> [!NOTE]
> The file detects the system language and will start in one of the available languages depending on your system.

```bash
Use: andistro <command> <option> to perform the desired task.

Example command to install:

    andistro -i debian

Example command to uninstall:
   andistro -d debian

Example command to start:
   andistro -s debian

Commands:
    -u    - updates all packages.
    -i    - installs the chosen option.
    -d    - uninstalls the chosen option.
    -s    - starts the chosen version.

Options:
    debian
    ubuntu
```

>[!NOTE]
> If you type the command `andistro` without any addition and press enter (↵), the selection menu will appear.