#!/bin/bash

# Dar permisos por si no los tiene
chmod +x start.sh

# Actualizar e instalar dependencias para Chrome
apt-get update
apt-get install -y wget unzip fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 libgbm1 libnspr4 libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 xdg-utils

# Descargar e instalar Google Chrome estable
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb

# Obtener versión Chrome instalada para ChromeDriver
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
echo "Versión de Chrome instalada: $CHROME_VERSION"

# Descargar versión compatible de ChromeDriver
CHROME_DRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
echo "Versión de ChromeDriver compatible: $CHROME_DRIVER_VERSION"

wget -q "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm chromedriver_linux64.zip

# Instalar selenium
pip install --upgrade pip
pip install selenium

# Ejecutar el script Python con BOT_ID o 1 por defecto
python tu_script.py ${BOT_ID:-1}
