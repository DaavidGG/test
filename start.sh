#!/bin/bash

set -e

echo "📦 Instalando dependencias necesarias..."
apt-get update
apt-get install -y wget unzip curl fonts-liberation libnss3 libxss1 libxkbcommon0 \
libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libxshmfence1

echo "🌐 Descargando e instalando Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install -y ./google-chrome-stable_current_amd64.deb

CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
echo "🌐 Chrome versión instalada: $CHROME_VERSION"

echo "🔧 Descargando ChromeDriver versión compatible..."
CHROME_DRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
wget https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm chromedriver_linux64.zip

echo "✅ ChromeDriver instalado correctamente."

echo "📦 Instalando dependencias de Python..."
pip install -U pip
pip install selenium

echo "🚀 Iniciando bots..."

# Cambia el número final para la cantidad de bots que deseas lanzar
for i in $(seq 1 3); do
  echo "🟢 Iniciando Bot $i"
  python kick_view.py $i &
  sleep 2
done

wait
