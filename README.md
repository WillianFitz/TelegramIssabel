Notificador de Mensagens de Voz via Telegram para Asterisk

Este projeto contém dois scripts Bash que monitoram a caixa postal do Asterisk e enviam mensagens de voz automaticamente para um grupo do Telegram sempre que um novo áudio `.wav` for recebido.

Funcionalidade

- Monitoramento contínuo da pasta de voicemail (`INBOX`) usando `inotifywait`.
- Envio automático de mensagem formatada com:
  - Número do remetente
  - Data/hora da gravação
- Envio do áudio `.wav` da mensagem de voz para um grupo do Telegram.
- Remoção automática dos arquivos após o envio.

Pré-requisitos

- Asterisk configurado com voicemail.
- 'inotify-tools' instalado:
  ```bash
  sudo apt install inotify-tools
  ```
- Um bot do Telegram criado e com permissão para enviar mensagens para o grupo.
- ID do grupo do Telegram e token do bot.

Estrutura

voicemail_monitor.sh           # Script que monitora a pasta de voicemail
enviar_voicemail_telegram.sh  # Script que envia a mensagem e o áudio para o Telegram
```
Configuração

1. **Edite os caminhos e variáveis nos scripts:**

   No `voicemail_monitor.sh`, edite a variável `VOICEMAIL_DIR` com o caminho da caixa postal desejada:
   VOICEMAIL_DIR="/var/spool/asterisk/voicemail/default/SEURAMAL/INBOX"
   ```

   No 'enviar_voicemail_telegram.sh', defina seu token e ID do grupo do Telegram:
   
   TOKEN="SEU TOKEN TELEGRAM"
   CHAT_ID="SEU ID DO GRUPO"
   ```

2. **Permissões de execução:**

   chmod +x voicemail_monitor.sh enviar_voicemail_telegram.sh
   ```

3. **Execução:**

   Execute o monitor em background (ou adicione ao systemd):

   ./voicemail_monitor.sh &
   ```

Exemplo de mensagem enviada ao Telegram

```
📞 Nova mensagem de voz  
👤 Número: 11999998888  
🕒 Data: 19/07/2025 09:32
```

Com o áudio em anexo.

Segurança

- Certifique-se de restringir permissões de leitura nos scripts para evitar vazamento do token do Telegram.
- O bot deve estar autorizado a interagir com o grupo.

Licença

Este projeto é open source entao contribuições, melhorias e sugestões são bem-vindas!

