#!/bin/bash

echo "📦 Instalando dependencias necesarias..."
apt-get update
apt-get install -y wget unzip curl fonts-liberation libnss3 libxss1 libxkbcommon0 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libxshmfence1

echo "🌐 Instalando Google Chrome..."
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

apt-get update
apt-get install -y google-chrome-stable

CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')

echo "🌐 Chrome versión instalada: $CHROME_VERSION"

echo "🔧 Descargando ChromeDriver versión compatible..."
CHROME_DRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)
echo "ChromeDriver versión: $CHROME_DRIVER_VERSION"

echo "✅ ChromeDriver instalado correctamente."

echo "📦 Instalando dependencias de Python..."
pip install -U pip
pip install selenium

echo "🚀 Iniciando bots..."

# Cambia 1 2 3 por el número de bots que quieras lanzar
for i in $(seq 1 3); do
  echo "🟢 Iniciando Bot $i"
  python kick_view.py $i &
  sleep 2
done

wait
