#!/bin/bash

set -e

echo "📦 Instalando dependencias necesarias..."
apt-get update
apt-get install -y wget unzip curl fonts-liberation libnss3 libxss1 libxkbcommon0 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libxshmfence1

echo "🌐 Instalando Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install -y ./google-chrome-stable_current_amd64.deb || apt-get install -fy

CHROME_VERSION=$(google-chrome --version | grep -oP '[0-9.]+' | head -1)
CHROME_MAJOR=$(echo $CHROME_VERSION | cut -d '.' -f 1)

echo "🌐 Chrome versión instalada: $CHROME_VERSION"

echo "🔧 Descargando ChromeDriver versión compatible..."
LATEST=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json" \
  | grep -B 2 "\"version\": \"$CHROME_VERSION\"" \
  | grep "url" \
  | grep "linux64/chromedriver-linux64.zip" \
  | cut -d '"' -f 4)

wget -q "$LATEST" -O chromedriver.zip
unzip chromedriver.zip
mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver

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
