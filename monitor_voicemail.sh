#!/bin/bash

VOICEMAIL_DIR="/var/spool/asterisk/voicemail/default/SEURAMAL/INBOX"

inotifywait -m -e moved_to "$VOICEMAIL_DIR" | \
while read path action file; do
    if [[ "$file" == *.wav ]]; then
        /usr/local/bin/enviar_voicemail_telegram.sh "$path$file"
    fi
done

