#!/bin/bash

# Source Vars
source $CONFIG

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Change to the Source Directory
cd ~

# Color
ORANGE='\033[0;33m'

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

# Change to the Output Directory
cd out/target/product/RMX2001

curl -T recovery.img temp.sh

link=curl -T recovery.img temp.sh

# Send the Message on Telegram
echo -e \
"
🦊 OrangeFox Recovery CI
✅ Build Completed Successfully!
📱 Device: "${DEVICE}"
🖥 Build System: "${TWRP_BRANCH}"
⬇️ Download Link: <a href=\"${link}\">Here</a>

📅 Date: "$(date +%d\ %B\ %Y)"
⏱ Time: "$(date +%T)"
" > tg.html

TG_TEXT=$(< tg.html)

telegram_message "$TG_TEXT"

echo " "

# Exit
exit 0
