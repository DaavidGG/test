#!/bin/bash

set -e

echo "📦 Instalando herramientas necesarias..."
apt-get update && apt-get install -y \
  wget \
  curl \
  unzip \
  gnupg \
  ca-certificates \
  fonts-liberation \
  libnss3 \
  libxss1 \
  libxkbcommon0 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  libdrm2 \
  libgbm1 \
  libxshmfence1 \
  libasound2t64 \
  python3-pip

echo "🌐 Descargando Google Chrome..."
wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "💾 Instalando Google Chrome..."
apt install -y ./google-chrome.deb || apt --fix-broken install -y

# Verifica si Chrome quedó instalado
if ! command -v google-chrome > /dev/null; then
  echo "❌ Google Chrome no se instaló correctamente."
  exit 1
fi

echo "🌍 Chrome instalado: $(google-chrome --version)"

# Instalar ChromeDriver correspondiente
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
CHROMEDRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION)

echo "⬇️ Descargando ChromeDriver $CHROMEDRIVER_VERSION..."
wget -O chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
unzip chromedriver.zip
mv chromedriver /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver
rm chromedriver.zip google-chrome.deb

echo "✅ ChromeDriver instalado."

echo "🐍 Instalando dependencias de Python..."
pip3 install -U pip selenium

echo "🚀 Iniciando bots..."
for i in $(seq 1 3); do
  echo "🟢 Iniciando Bot $i"
  python3 kick_view.py $i &
  sleep 2
done

wait
