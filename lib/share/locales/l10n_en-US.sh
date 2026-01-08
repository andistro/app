#!/bin/bash

# Translated and updated using pt-BR as reference

#=====================================================================================================

#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# AndDistro executable specific definitions

# Global andistro
distro_command_guide="AndDistro Commands Guide"
distro_desc_line_0="Usage: andistro to perform the desired task."
distro_desc_line_0_0="Usage: andistro to perform the desired task."

## Termux exclusive andistro
distro_desc_line_t1="Example of a command that allows initialization:"
distro_desc_line_t2=" andistro -s"
distro_desc_line_t3="Example of a command that allows uninstallation:"
distro_desc_line_t4=" andistro -d"
distro_desc_line_t5="Example of a command that allows installation:"
distro_desc_line_t6=" andistro -i"
distro_desc_line_t7="Example of a command that allows installation without graphical interface"
distro_desc_line_t8=" andistro -i terminal-mode"
distro_desc_line_t9="Example of a command that allows updating AnDistro:"
distro_desc_line_t10=" andistro -u"
distro_desc_line_t11=" -u updates AnDistro."
distro_desc_line_t12=" -s initializes Debian."
distro_desc_line_t13=" -d uninstalls Debian."
distro_desc_line_t14=" -i installs Debian."

label_andistro_install_system="Install the Debian system"
label_andistro_start_system="Start the Debian system"
label_andistro_termianl_viewer="View as terminal"
label_andistro_updater="Update AnDistro"
label_andistro_uninstall_system="Uninstall the Debian system"
label_andistro_uninstalling_complete="Complete uninstallation of AnDistro!"
label_andistro_battery_optimization="Remove battery optimization"
label_andistro_signal9_error="Resolve signal 9 error"
label_andistro_storage_permission_check="Check storage permission"
label_andistro_install_avnc="Install AVNC"

label_autoboot_andistro="Initialization"
label_autoboot_andistro_desc="When enabled, every time Termux is opened, there will be a question asking whether you want to start AnDistro or not and the command necessary to make the decision."
label_enable_autoboot_andistro="Enable AnDistro startup message"
label_disable_autoboot_andistro="Disable AnDistro startup message"

label_andistro_uninstall="Uninstall AnDistro"

label_andistro_adb_configs="ADB settings"
label_andistro_adb_configs_desc="Caution is necessary for this configuration. \n\nIf you have any doubts, consult the AnDistro documentation or use the Termux communities to ask questions.\n\nThe configurations that will be made here will make changes to more sensitive settings and, depending on the case, you may need to restore the device to factory defaults.\n\nClick < Continue > if you want to access these options or click < Close > to return to AnDistro's main menu."

label_andistro_adb_pair="ADB pairing"
label_andistro_adb_pair_title="Allow ADB access to Termux"
label_andistro_adb_pair_desc="ATTENTION: READ EVERYTHING. \n\n1. Click < Open > to open your device's developer settings and look for the option called 'Wi-Fi Debugging'; \n2. Enable it and, within the option, click 'Pair device with pairing code'; \n3. Wait to receive notifications and enter the codes that are requested; \n4. In no way, on the Wi-Fi Debugging screen, use the back gesture or go to the home screen. This will restart the code and you will have to redo everything again. Only use the notification center to send the codes."

label_andistro_notify_adb_pair_title_success="✅ ADB Pairing Finished!"
label_andistro_notify_adb_pair_success_desc="Return to Termux to finish ADB settings."
label_andistro_notify_adb_pair_title_error="❌ Error in ADB Pairing"
label_andistro_notify_adb_pair_error_desc="It will be necessary to restart the pairing settings"

label_andistro_adb_connect="Connect to ADB"
label_andistro_adb_connect_title_success="✅ ADB Connection Finished!"
label_andistro_adb_connect_title_error="❌ Error in ADB Connection"
label_andistro_adb_connect_verify="Checking whether Termux has a connection with Wi-Fi debugging"
label_andistro_adb_already_connected="Termux is already connected to ADB."

label_andistro_disable_ghost_process_monitor="Disable ghost process monitor"
label_andistro_enable_dev_mode="Enable developer mode"
label_andistro_start_command_info="Type 'andistro' to start AnDistro.\nPress ENTER (↲) to confirm."

## AndDistro distros exclusive
distro_desc_line_d1=" --boot command to start some configuration."
distro_desc_line_d2="Subcommands of --boot"
distro_desc_line_d3=" vnc to start the VNC server"
distro_desc_line_d4="Subcommands of --boot vnc"
distro_desc_line_d5=" --display defines the screen resolution to be displayed"
distro_desc_line_d6=" --scale defines the screen scale (1 or 2)"
distro_desc_line_d7=" --port defines the port used by the server."
distro_desc_line_d8="The --scale command only works on xfce4, if you use it on lxde, the command will be ignored"
distro_desc_line_d9="The --display and --port commands are not mandatory and if you do not use them, the server will start at the default resolution and port."
distro_desc_line_d10="Example of a command that allows starting the VNC server"
distro_desc_line_d11="Simple mode"
distro_desc_line_d12=" andistro --boot vnc"
distro_desc_line_d13="Full mode"
distro_desc_line_d14=" andistro --boot vnc --display 1920x1080 --port 1 --scale 1"
distro_desc_line_d15="Usage: andistro --termux-cmd \"TERMUX_COMMAND\""

#//////////////////////////////////////////////////////////////////////////////////////////////////////

#=====================================================================================================

# Waits and loading
label_progress="In progress..."
label_upgrade="Upgrading the system..."
label_wait="Please wait"

# Download
label_distro_download="Downloading %s..."
label_distro_download_finish="The latest version of %s was downloaded successfully."
label_distro_download_start="Soon the latest version of %s will be downloaded to storage..."
label_install_script_download="Downloading necessary files..."
label_skip_download="Skipping download"
label_update_finish="Update completed!"
label_wallpaper_download="Downloading wallpapers..."

# Settings
label_keyboard_setup="Starting keyboard settings, please wait...."
label_keyboard_active_sugest="If necessary, tap the keyboard button (⌨) to open the keyboard"
label_system_setup="Configuring the system..."
label_xdg_user_dirs_setup="Configuring default folders for the system..."

# Information
commands_available_to_you="Available commands for you:"
label_command_not_found="Command not found:"
label_dialog_display_menu_sugestion="Screen Resolution Suggestions"
label_dialog_display_menu_sugestion_desc="Do you want a dialog box with screen resolution suggestions to appear every time the system starts?"
label_dialog_uninstall_menu="Do you want to continue with the uninstallation?"
label_dialog_uninstall_menu_desc="You are about to uninstall the %s system.\n\nAll data related to this system will be lost.\nTHIS IS AN IRREVERSIBLE ACTION.\n\nDo you want to continue?"
label_termux_settings="Termux settings"
label_open_termux_settings="After clicking \"Ok\" the Termux information in the system will be opened."

label_finalizing_setup="Finalizing the settings of %s..."
label_opening="Opening %s..."

label_android_device_info="Android device information"
label_android_device_info_desc="After clicking '< Open >' the Android device information screen will be opened in the system settings."
label_android_device_info_desc_dev_mode="To enable developer mode, find the item \"Build Number\" and tap it 7 times in a row. You may be asked for the device unlock password.\n\nIf you can't find it, look for software information.\n\nAfter enabling developer mode, return to Termux and continue with the installation."

label_open_termux="Open Termux"

label_notify_adb_code_button="Enter the code"
label_notify_adb_pair_code_title="Enter the pairing code"
label_notify_adb_pair_code_desc="6-digit code highlighted, next to or below the \"Wi-Fi Pairing Code\" description"
label_notify_adb_pair_port_code_title="Enter the port code"
label_notify_adb_pair_port_code_desc="The code that appears right after $wlan_ip_localhost:_____"

label_termux_api_not_installed="Termux:API is not installed. Install it so that some settings can be made in AnDistro."

## Timezone
label_system_timezone="Timezone"
label_distro_alert_timezone_desc="The timezone will be the same as the device."
label_distro_alert_timezone_detected="Detected timezone: "

# Alerts
label_uninstall_success="Uninstallation completed!"
label_uninstalling_system="Uninstalling system %s"
label_uninstall_cancelled="The uninstallation of system %s was cancelled"
label_install_success="Installation completed!"
label_setup_apply="Setting applied!"

# Passwords
label_change_password="The password has been changed successfully. "
label_password_forgot="Forgot your password? Use the command 'andistro --boot vnc --passwd' to reset the password."
label_password_input="Enter the new password for the VNC server"
label_password_input_alert_important="It is necessary to set a password!"
label_password_save_failed="Failed to save password!"

# Choices
label_choose_one_of_the_option="Choose one of the options"
label_choose_language="Choose the language "
label_choose_theme="Choose a theme"

# Unavailability
label_command_not_available="This command is not available for the current system."
label_system_not_found="System not found."

# Errors and refusals
label_entry_canceled="Entry canceled by user."
label_command_problem_andistro_for_distro="This command only works if you end the system."
label_error_dir_termux_home_not_accessible="Error: /termux/home directory is not accessible within Debian."
label_error_bridge_unavailable="Error: bridge unavailable"
label_action_denied="Action denied"
label_problem="There was a problem"
label_no_command_informed="No command was provided"
label_error_bridge_unavailable="The bridge between Debian and Termux is not available at the moment. Try again later."
label_error_bridge_timeout="The bridge with Termux did not respond within the time limit. Termux may not be open or the listener may not be running. Try again after restarting the system."

# Tip
label_info_command_andistro_start="Use the 'andistro' command to start."
label_select_no_to_choose_other_resolution="Select 'No' to choose another resolution."
label_start_dialog_display="If you want to start the server with interactive screen, use the command:\nandistro --boot vnc --dialog-display"

# Single-word messages
label_error="Error"
label_done="Finished"
label_width="Width"
label_height="Height"
label_scale="Scale"
label_port="Port"
label_localhost="Local"
label_confirm="Confirm"
label_cancel="Cancel"
label_themes="Themes"
label_icons="Icons"
label_light="Light"
label_dark="Dark"
label_resolution="Resolution"
label_landscape="Landscape"
label_portrait="Portrait"
label_user="User"
label_password="Password"
label_password_alt_min="password"
label_back="Back"
label_next="Next"
label_help="Help"
label_proceed="Proceed"
label_install="Install"
label_ignore="Ignore"
label_warning="Warning"
label_skip="Skip"
label_attention="Attention"
label_settings="Settings"
label_settings_and_help="Settings and Help"
label_yes="Yes"
label_no="No"
label_close="Close"
label_open="Open"
label_pairing="Pairing"

# Messages in brackets
label_detected="[Detected]"
label_numbers_only="[NUMBERS ONLY]"

# Interface
label_config_environment_gui="Configuring interface..."
label_install_environment_gui="Downloading settings for the interface to work..."
label_environments_select="Choose a desktop interface: "
label_environments_select_default="Default"
label_environments_select_light="Light"
label_environments_select_null="None"

# Search
label_file_not_found="Location file not found"
label_find_update="Looking for updates..."
label_system_found="System identified!"
label_system_not_found="System not identified!"

# Permissions
label_permission_granted="Already allowed"
label_permission_retired="Already removed"
label_permission_not_granted="Could not grant"
label_permission_help="Help with permission"
label_open_configs="Open settings."
label_delay_later="I'll leave it for later"
label_stop_and_open="You chose to stop. Nothing was opened."
label_action_denied="Action: denied (ESC) or CTRL+C."
label_invalid_key="Invalid key, questionnaire closed."
label_no_open="You chose NOT to open. Nothing was opened."
label_cancel_action="You chose to cancel the action."
label_continue_action="You chose to proceed with the action."
label_cancel_action_ctrlc="You pressed CTRL+C. You chose NOT to run. Nothing was done."
label_cancel_action_esc="You pressed ESC. You chose NOT to run. Nothing was done."
label_continue_action_executed="You chose to execute. One moment..."
label_action_accepted="The request was accepted."
label_app_not_open="If the application does not open, verify that it is installed."

label_storage_permission_check="Checking storage permissions..."
label_storage_permission_granted="Already have access to storage."
label_storage_permission="Storage permission"
label_storage_permission_desc="Allow AnDistro to have access and be able to manage the phone storage.\n\nThis allows access to photos, videos, music, audio and other files on this device."
label_storange_permission_help_desc="Click the \"Allow access\" button in settings to grant storage access.\n\nAfter allowing, return to Termux and press \"Already allowed\"."

label_battery_optimization="Battery optimization"
label_battery_optimization_desc="To prevent the system from terminating Termux/AnDistro in the background, it is recommended to remove battery optimization.\n\nOn the next screen, look for the Termux application, open it and choose the \"No restrictions\" or \"Unrestricted\" mode."
label_battery_optimization_desc_info="This adjustment is essential to maintain Termux performance. Have you already adjusted Termux battery optimization to \"No restrictions\" / \"Unrestricted\"?\n\nNo matter which option you choose, this step will be completed now."

label_avnc_desc="Do you already have AVNC installed?\nIf not, click the button and after starting the installation, return here. If you already have it installed or do not want to install it on your phone, click \n\nThe app is not mandatory, but it is recommended.\nYou can use any other VNC viewing app."

label_disable_ghost_process_monitor_desc="Do you want to disable the Phantom Process monitor?\n This is the cause of the error message '[Process completed (signal 9) - press Enter]'\n\nAnDistro brings this option that allows disabling the ghost process monitor, but does not have the option to restore to factory defaults. If you want to restore these options you will need to consult the ADB documentation or restore your phone"

label_open_app_desc="Do you want to start %s?\nIf yes, press ENTER (↲).\nOtherwise, press ESC or CTRL+C to ignore."

label_autoboot_andistro_desc="Do you want to receive a warning to start AnDistro every time you open Termux?\n AnDistro will not be started automatically, you will need to confirm with enter (↲) after the message appears."
label_autoboot_andistro_disable_desc="Do you want to DISABLE AnDistro's autoboot?\n\nThis will remove the warning message that appears every time Termux starts."

# Timer
label_sleep_in_10s="This message will disappear in 10 seconds."

# System
label_distro_boot="The %s system has been started"
label_distro_not_installed="%s is not installed."
label_distro_not_installed_desc="%s has not yet been installed, follow the steps below to install it:\nType the 'andistro' command followed by enter (↲), choose the install option. Then choose %s to start the installation."
label_distro_installed="%s is already installed."

# Server
label_server_kill_desc="Shutting down the server..."
label_server_kill_desc_help="To shut down the VNC server, use the command:\n→ 'andistro --boot vnc --kill'"
label_server_kill_desced="Shutting down the server on port"
label_server_kill_desc_error="No VNC server found for user $USER"
label_server_setup="Server setup"
label_server_start_desc="The server has been started."
label_server_start_error="The VNC server is not running. Please check the error log in .vnc/localhost.log."
label_select_resolution="Resolution selection"
label_choose_one_resolution="Choose one of the options below"

label_resolution_frequent="Frequent Resolution Detected"
label_resolution_frequent_desc="You have been using the %s resolution lately.\n\nDo you want to set this resolution as default?\n\nThis will prevent the selection menu from appearing next time."
label_resolution_remove_default="Do you want to remove the default resolution?"
label_resolution_remove_default_desc="You are about to remove the saved default resolution.\n\nThis will cause the resolution selection menu to appear again the next time you start the VNC.\n\nDo you want to continue?"
label_resolution_remove_default_sucess="The resolution is no longer the default."

label_resolution_option_default="Default resolution"
label_resolution_option_default_desc="Confirm to start with the resolution set as default. \n\nPress '' to confirm or press enter (↲). \nPress '' to choose another resolution."
label_resolution_choose_options="Choose some options"
label_resolution_choose_default="You chose to use the default resolution"
label_resolution_choose_custom="You chose to set the resolution manually"
label_resolution_choose_custom_desc="Enter the custom resolution in WIDTHxHEIGHT format. Example: 1920x1200"
label_resolution_choose_custom_desc_port="Set a number for the port or keep the one set as default. The default port is 1."
label_resolution_choose_custom_desc_scale="Set a number for the scale or keep the one set as default. The default scale is 1."
label_resolution_choose_custom_desc_alert="There was an error in the data entered. It will return to the previous screen. Read the description carefully and repeat the procedure."

label_resolution_option_custom="Set resolution manually"
label_resolution_option_uwhd="Ultrawide HD"
label_resolution_option_qdhd="Quad-HD"
label_resolution_option_fhd="Full-HD"
label_resolution_option_fhd_wide="Full-HD extended"
label_resolution_option_hd="HD"