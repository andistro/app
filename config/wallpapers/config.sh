#!/bin/bash
# Fonte modular configuração global
source "/usr/local/bin/global"

show_progress_dialog steps-multi-label 17 \
    "${label_wallpaper_download}\n\n → AnDistro" 'mkdir -p /usr/share/backgrounds/andistro'\
    "${label_wallpaper_download}\n\n → AnDistro" 'wget -P "/usr/share/backgrounds/andistro" "${extralink}/config/wallpapers/AnDistro/0.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro" 'wget -P "/usr/share/backgrounds/andistro" "${extralink}/config/wallpapers/AnDistro/1.jpg"' \
    "${label_wallpaper_download}\n\n → AnDistro" 'wget -P "/usr/share/backgrounds/andistro" "${extralink}/config/wallpapers/AnDistro/2.jpg"' \
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/vertical'\
    "${label_wallpaper_download}\n\n → Unsplash: " 'mkdir -p /usr/share/backgrounds/unsplash/horizontal'\
    "${label_wallpaper_download}\n\n → Unsplash: mikehindle-BXvcjmM6dH8" 'wget -O "/usr/share/backgrounds/unsplash/mikehindle-BXvcjmM6dH8.jpg" "https://unsplash.com/photos/BXvcjmM6dH8/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: mikehindle-CjV322K-pdA" 'wget -O "/usr/share/backgrounds/unsplash/mikehindle-CjV322K-pdA.jpg" "https://unsplash.com/photos/CjV322K-pdA/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: martz90-rMRT4hF-Fsg" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/martz90-rMRT4hF-Fsg.jpg" "https://unsplash.com/photos/rMRT4hF-Fsg/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: marekpiwnicki-7c4Gxa6598I" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/marekpiwnicki-7c4Gxa6598I.jpg" "https://unsplash.com/photos/7c4Gxa6598I/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: milad-fakurian-cTlimlJPNE4" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/milad-fakurian-cTlimlJPNE4.jpg" "https://unsplash.com/photos/cTlimlJPNE4/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: piensaenpixel-VfeXGzHqA2I" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/piensaenpixel-VfeXGzHqA2I.jpg" "https://unsplash.com/photos/VfeXGzHqA2I/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: intricateexplorer-DndBf3D8NKs" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/intricateexplorer-DndBf3D8NKs.jpg" "https://unsplash.com/photos/DndBf3D8NKs/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: jonakoh-HxtvH28DSVM" 'wget -O "/usr/share/backgrounds/unsplash/horizontal/jonakoh-HxtvH28DSVM.jpg" "https://unsplash.com/photos/HxtvH28DSVM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: hngstrm-XWKP0yH2DeY" 'wget -O "/usr/share/backgrounds/unsplash/vertical/hngstrm-XWKP0yH2DeY.jpg" "https://unsplash.com/photos/XWKP0yH2DeY/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: sunx-w36l29U4PmM" 'wget -O "/usr/share/backgrounds/unsplash/vertical/sunx-w36l29U4PmM.jpg" "https://unsplash.com/photos/w36l29U4PmM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: joshrh19-g6Cub2i9RBM" 'wget -O "/usr/share/backgrounds/unsplash/vertical/joshrh19-g6Cub2i9RBM.jpg" "https://unsplash.com/photos/g6Cub2i9RBM/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: heysupersimi--TJ_dqai1QE" 'wget -O "/usr/share/backgrounds/unsplash/vertical/heysupersimi--TJ_dqai1QE.jpg" "https://unsplash.com/photos/-TJ_dqai1QE/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: heysupersimi-lI06Ce8Tam0" 'wget -O "/usr/share/backgrounds/unsplash/vertical/heysupersimi-lI06Ce8Tam0.jpg" "https://unsplash.com/photos/lI06Ce8Tam0/download"' \
    "${label_wallpaper_download}\n\n → Unsplash: kevinmueller-NdK8Ed-Qx3U" 'wget -O "/usr/share/backgrounds/unsplash/vertical/kevinmueller-NdK8Ed-Qx3U.jpg" "https://unsplash.com/photos/NdK8Ed-Qx3U/download"'

rm -rf wallpapers.sh