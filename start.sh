#!/bin/bash

echo "📦 Instalando herramientas necesarias..."
apt-get update
apt-get install -y wget curl unzip gnupg ca-certificates fonts-liberation libnss3 libxss1 libxkbcommon0 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libxshmfence1 libasound2

echo "🧹 Limpiando versiones previas..."
rm -f google-chrome-stable_current_amd64.deb*

echo "🌐 Descargando Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "💾 Instalando Google Chrome..."
apt-get install -y ./google-chrome-stable_current_amd64.deb || apt --fix-broken install -y

# Verifica si Chrome quedó instalado
if ! command -v google-chrome > /dev/null; then
  echo "❌ Google Chrome no se instaló correctamente."
  exit 1
fi

echo "🌍 Versión de Chrome:"
google-chrome --version

# ChromeDriver
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
CHROME_DRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)

echo "⬇️ Descargando ChromeDriver $CHROME_DRIVER_VERSION..."
wget https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm chromedriver_linux64.zip

echo "✅ ChromeDriver instalado."

echo "🐍 Instalando dependencias de Python..."
pip install -U pip selenium

echo "🚀 Iniciando bots..."
for i in $(seq 1 3); do
  echo "🟢 Iniciando Bot $i"
  python kick_view.py $i &
  sleep 2
done

wait
