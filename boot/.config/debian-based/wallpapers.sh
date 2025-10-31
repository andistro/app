#!/bin/bash
# Fonte modular configuração global
source "/usr/local/bin/andistro/global"

show_progress_dialog steps-multi-label 22 \
    "${label_wallpaper_download}\n\n → AnDistro: " 'mkdir -p /usr/share/backgrounds/andistro'\
    "${label_wallpaper_download}\n\n → AnDistro: Light" 'wget -O "/usr/share/backgrounds/andistro/andistro-light.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/light.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Medium" 'wget -O "/usr/share/backgrounds/andistro/andistro-medium.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/medium.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro: Dark" 'wget -O "/usr/share/backgrounds/andistro/andistro-dark.jpg" "https://gitlab.com/andistro/wallpapers/-/raw/main/dark.jpg"' \
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/portrait'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/landscape'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/square'\
    "${label_wallpaper_download}\n\n → Unsplash: martz90-rMRT4hF-Fsg" 'wget -O "/usr/share/backgrounds/unsplash/landscape/martz90-rMRT4hF-Fsg.jpg" "https://unsplash.com/photos/rMRT4hF-Fsg/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: marekpiwnicki-7c4Gxa6598I" 'wget -O "/usr/share/backgrounds/unsplash/landscape/marekpiwnicki-7c4Gxa6598I.jpg" "https://unsplash.com/photos/7c4Gxa6598I/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: milad-fakurian-cTlimlJPNE4" 'wget -O "/usr/share/backgrounds/unsplash/landscape/milad-fakurian-cTlimlJPNE4.jpg" "https://unsplash.com/photos/cTlimlJPNE4/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: piensaenpixel-VfeXGzHqA2I" 'wget -O "/usr/share/backgrounds/unsplash/landscape/piensaenpixel-VfeXGzHqA2I.jpg" "https://unsplash.com/photos/VfeXGzHqA2I/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: intricateexplorer-DndBf3D8NKs" 'wget -O "/usr/share/backgrounds/unsplash/landscape/intricateexplorer-DndBf3D8NKs.jpg" "https://unsplash.com/photos/DndBf3D8NKs/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: jonakoh-HxtvH28DSVM" 'wget -O "/usr/share/backgrounds/unsplash/landscape/jonakoh-HxtvH28DSVM.jpg" "https://unsplash.com/photos/HxtvH28DSVM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: hngstrm-XWKP0yH2DeY" 'wget -O "/usr/share/backgrounds/unsplash/portrait/hngstrm-XWKP0yH2DeY.jpg" "https://unsplash.com/photos/XWKP0yH2DeY/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: sunx-w36l29U4PmM" 'wget -O "/usr/share/backgrounds/unsplash/portrait/sunx-w36l29U4PmM.jpg" "https://unsplash.com/photos/w36l29U4PmM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: joshrh19-g6Cub2i9RBM" 'wget -O "/usr/share/backgrounds/unsplash/portrait/joshrh19-g6Cub2i9RBM.jpg" "https://unsplash.com/photos/g6Cub2i9RBM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: heysupersimi--TJ_dqai1QE" 'wget -O "/usr/share/backgrounds/unsplash/portrait/heysupersimi--TJ_dqai1QE.jpg" "https://unsplash.com/photos/-TJ_dqai1QE/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: heysupersimi-lI06Ce8Tam0" 'wget -O "/usr/share/backgrounds/unsplash/portrait/heysupersimi-lI06Ce8Tam0.jpg" "https://unsplash.com/photos/lI06Ce8Tam0/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: kevinmueller-NdK8Ed-Qx3U" 'wget -O "/usr/share/backgrounds/unsplash/portrait/kevinmueller-NdK8Ed-Qx3U.jpg" "https://unsplash.com/photos/NdK8Ed-Qx3U/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: mikehindle-BXvcjmM6dH8" 'wget -O "/usr/share/backgrounds/unsplash/square/mikehindle-BXvcjmM6dH8.jpg" "https://unsplash.com/photos/BXvcjmM6dH8/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: mikehindle-CjV322K-pdA" 'wget -O "/usr/share/backgrounds/unsplash/square/mikehindle-CjV322K-pdA.jpg" "https://unsplash.com/photos/CjV322K-pdA/download"'