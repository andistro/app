#!/bin/bash
# Fonte modular configuração global
source "/usr/local/bin/global"

show_progress_dialog steps-multi-label 4 \
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/vertical'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/horizontal'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'wget -O "/usr/share/background/unsplash/horizontal/martz90-rMRT4hF-Fsg.jpg" "https://unsplash.com/photos/rMRT4hF-Fsg/download"'