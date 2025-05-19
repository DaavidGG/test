#!/bin/bash

apt-get update
apt-get install -y wget unzip curl gnupg2 software-properties-common

# Instalar Google Chrome
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

apt-get update
apt-get install -y google-chrome-stable

# Obtener versión Chrome
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
echo "Versión Chrome: $CHROME_VERSION"

# Descargar ChromeDriver compatible
CHROME_DRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
echo "ChromeDriver versión: $CHROME_DRIVER_VERSION"

wget -q "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm chromedriver_linux64.zip

# Instalar Python selenium
pip install --upgrade pip
pip install selenium

# Ejecutar el script Python con BOT_ID o 1 por defecto
for i in $(seq 1 100)
do
  python kick_view.py $i &
done
wait
