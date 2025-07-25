#!/bin/bash

if command -v getprop > /dev/null 2>&1; then
    system_country=$(getprop ro.csc.country_code 2>/dev/null)              # Country
fi

# If ~/.bashrc file doesn't exist, create an empty one
if [ ! -f ~/.bashrc ]; then
  touch ~/.bashrc
fi

# If LANG=en_US.UTF-8 line exists in ~/.bashrc
if grep -q "LANG=en_US.UTF-8" ~/.bashrc; then
  export LANGUAGE=en_US_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi

#=====================================================================================================\
distro_wait="wait"
distro_del="uninstall"
distro_instaled="installed"
distro_install="install"
distro_update="update"
distro_start="start"
distro_notinstaled="not installed"
distro_command="<command>"
distro_command_not_found="Command not found:"
distro_option="<option>"
distro_desc_line_1="Use: andistro <command> <option> to perform the desired task."
distro_desc_line_2="Example command for installation:"
distro_desc_line_3="   andistro install debian"
distro_desc_line_4="Example command for uninstallation:"
distro_desc_line_5="   andistro uninstall debian"
distro_desc_line_6="Example command for starting:"
distro_desc_line_7="   andistro start debian"
distro_desc_line_8="Commands:"
distro_desc_line_9="    update - updates all packages."
distro_desc_line_10="    install - installs the chosen option."
distro_desc_line_11="    uninstall - uninstalls the chosen option."
distro_desc_line_12="    start - starts the chosen version."
distro_desc_line_13="Options:"
label_detected="[Detected]"
label_distro_alert_timezone_desc="The timezone will be the same as the device."
label_distro_alert_timezone_detected="Detected timezone: "
label_sleep_in_5s="This message will disappear in 5 seconds."
label_sleep_in_10s="This message will disappear in 10 seconds."
label_keyboard_setup="Starting keyboard settings, $distro_wait...."
label_tzdata_setup="Starting timezone and date settings, $distro_wait...."
#=====================================================================================================

label_distro_stable="Stable"
label_distro_previous_version="Previous version"

label_system_info="Your system information"
label_android_version="Android version"
label_device_manufacturer="Brand"
label_device_model="Model"
label_device_hardware="Chipset"
label_android_architecture="Architecture"
label_android_architecture_unknow="Architecture not identified"
label_system_country="Region"
label_system_country_iso="Abbreviation"
label_system_icu_locale_code="Language code"
label_system_timezone="Timezone"
desc_system_info="Use the ./sys-info command to see this information again."
label_progress="In progress..."
label_language_download="Downloading your language settings..."
label_create_boot="Creating boot..."
label_alert_autoupdate_for_u="I'm updating myself so the system works well for you."
label_find_update="Looking for updates..."
label_upgrade="Updating system..."
label_install_tools="Installing tools..."
label_system_setup="Setting up system..."
label_system_language="Setting up language..."
label_updating_packages="Please wait, updating packages..."
label_keyboard_settings="Getting keyboard settings..."
label_tzdata_settings="Getting keyboard and timezone settings..."
label_config_environment_gui="Configuring interface..."
label_install_environment_gui="Downloading necessary settings for the interface to work..."
label_start_script="Writing startup script"
label_entry_canceled="Entry canceled by user."
label_sucess="Success!"
label_change_password="VNC password changed successfully. "

#VNC
label_vnc_setup="VNC Setup"
label_vnc_password_input="Enter the new password for the VNC server: "
label_startvnc_desc="VNC server started. Default password is the account password "
label_vncserver_localhost="Local:"
label_vncserver_password_forgot="Forgot your password? Use the 'vncpasswd' command to reset the VNC password."
label_vncserver_kill="Shutting down VNC server..."
label_vncserver_kill_port="Enter the port number you want to close (example: 1): "
label_vncserver_killed="Shutting down VNC on port"
label_vncserver_kill_error="No VNC server found for user $USER"
label_vncserver_resolution_title="Resolution selection"
label_vncserver_resolution_option="Choose one of the options below:"
label_vncserver_resolution_option_uwhd="Start vncserver in Ultrawide HD resolution"
label_vncserver_resolution_option_qdhd="Start vncserver in Quad-HD resolution"
label_vncserver_resolution_option_fhd="Start vncserver in Full-HD resolution"
label_vncserver_resolution_option_hd="Start vncserver in HD resolution"
label_vncserver_resolution_option_custom="Start vncserver with custom resolution and port"

label_vncserver_chose_resolution_uwhd="You chose Ultra Wide HD resolution"
label_vncserver_chose_resolution_qdhd="You chose Quad-HD resolution"
label_vncserver_chose_resolution_fhd="You chose Full HD resolution"
label_vncserver_chose_resolution_hd="You chose HD resolution"
label_vncserver_chose_resolution_custom="You chose to set resolution and port manually"
label_vncserver_chose_resolution_custom_desc="Enter custom resolution in WIDTHxHEIGHT format. Example: 1920x1200"
label_vncserver_chose_resolution_custom_desc_port="Enter the port number. Example: 2. Default port is 1"

# About downloads
label_install_script_download="Downloading installation script..."
label_install_script_download_check="Confirming installation..."
label_skip_download="Skipping download"
label_decopressing_rootfs="Decompressing files..."
label_wallpaper_download="Downloading wallpaper..."
label_gnome_download_setup="Downloading necessary settings for Gnome..."

#System download
label_ubuntu_download="Downloading Ubuntu..."
label_ubuntu_download_extract="Extracting Ubuntu to storage..."

label_debian_download="Downloading Debian..."
label_debian_download_extract="Extracting Debian to storage..."

#DIALOG MENU TITLES
MENU_operating_system_select="Choose the operating system to be installed: "
MENU_language_select="Choose the language "
MENU_language_selected="Selected language: "
MENU_environments_select="Choose a desktop environment: "