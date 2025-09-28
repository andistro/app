#!/data/data/com.termux/files/usr/bin/bash
system_icu_locale_code=$(getprop persist.sys.locale 2>/dev/null)
declare -A LANG_CODES
LANG_CODES["pt-BR"]="Português do Brasil (pt-BR)"
LANG_CODES["en-US"]="English (en-US)"

if [[ -n "${LANG_CODES[$system_icu_locale_code]}" ]]; then
    system_lang_code="$system_icu_locale_code"
else
    system_lang_code="en-US"
fi

TERMO="termos.txt"

if [ "$system_lang_code" = "en-US" ]; then
cat > "$TERMO" << EOF
TERMS OF USE

1. By using the AnDistro installer, the user understands that:

2. The project is not responsible for the use of the application on your device or for any potential damages.

3. The installer does not collect any user data during its operation and is not responsible for third parties.

4. All source code is open and available in the official GitHub repository for inspection and verification.

5. Not all Android devices are guaranteed to work properly, as technical limitations may occur due to different system versions and restrictions imposed by Android itself.

6. By proceeding, the user acknowledges these conditions.
EOF
elif [ "$system_lang_code" = "pt-BR" ]; then
cat > "$TERMO" << EOF
TERMOS DE USO

1. Ao utilizar o instalador AnDistro, o usuário entende que:

2. O projeto não se responsabiliza pelo uso do aplicativo em seu dispositivo ou por eventuais danos.

3. O instalador não coleta nenhum dado do usuário durante o uso do instalador e não se responsabiliza por terceiros.

4. Todo o código-fonte é aberto e está disponível no repositório oficial do GitHub para consulta e verificação.

5. Nem todos os dispositivos Android terão funcionamento garantido, podendo ocorrer limitações técnicas devido às diferentes versões do sistema e restrições impostas pelo próprio Android.

6. Ao prosseguir, o usuário reconhece estas condições.
EOF
fi

if [ "$system_lang_code" = "en-US" ]; then
    label_term="Terms of Use"
    label_accept="Accept"
    label_reject="Reject"
    label_u_accepted="User accepted the terms. Continuing..."
    label_u_rejected="You have rejected the terms. The file will be deleted. To use again, download it again."
elif [ "$system_lang_code" = "pt-BR" ]; then
    label_term="Termos de Uso"
    label_accept="Aceitar"
    label_reject="Negar"
    label_u_accepted="Usuário aceitou os termos. Continuando..."
    label_u_rejected="Você recusou os termos. O arquivo será excluído. Caso queira utilizar novamente, será necessário baixá-lo outra vez."
fi


dialog --title "$label_term" --yes-label "$label_accept" --no-label "$label_reject" \
       --yesno "$(cat $TERMO)" 20 70

resposta=$?

if [ $resposta -eq 0 ]; then
    # Usuário aceitou
    echo "$label_u_accepted"
    rm -rf "$TERMO"
    rm -rf termos.sh
    # aqui é onde você coloca o que já seria feito
elif [ $resposta -eq 1 ]; then
    # Usuário recusou
    dialog --msgbox "$label_u_rejected" 10 60
    andistro -d total
fi

clear
