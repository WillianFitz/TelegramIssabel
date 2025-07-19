#!/bin/bash

TOKEN="SEU TOKEN TELEGRAM"
CHAT_ID="SEU ID DO GRUPO"
WAV_FILE="$1"
TXT_FILE="${WAV_FILE%.wav}.txt"

if [ -f "$TXT_FILE" ]; then
    RAW_CALLERID=$(grep "callerid=" "$TXT_FILE" | cut -d= -f2)
    FROM=$(echo "$RAW_CALLERID" | sed -E 's/.*<([^>]+)>.*/\1/')

    RAW_DATE=$(grep "origdate=" "$TXT_FILE" | cut -d= -f2-)

    DATE=$(date -d "$RAW_DATE" +"%d/%m/%Y %H:%M")

    MSG="📞 <b>Nova mensagem de voz</b>%0A👤 <b>Número:</b> $FROM%0A🕒 <b>Data:</b> $DATE"
else
    MSG="📞 <b>Nova mensagem de voz recebida!</b>"
fi

curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d parse_mode="HTML" \
     -d text="$MSG"

curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendAudio" \
     -F chat_id="$CHAT_ID" \
     -F audio=@"$WAV_FILE"

rm -f "$WAV_FILE" "$TXT_FILE"

