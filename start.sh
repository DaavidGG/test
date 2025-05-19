#!/bin/bash
set -e

echo "📦 Instalando dependencias del sistema..."
apt-get update && apt-get install -y \
  curl \
  unzip \
  gnupg \
  ca-certificates \
  python3-pip \
  libnss3 \
  libxss1 \
  libxkbcommon0 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  libdrm2 \
  libgbm1 \
  libxshmfence1 \
  libasound2t64 \
  fonts-liberation \
  libu2f-udev

echo "🌐 Descargando e instalando Google Chrome directamente..."
curl -sSL -o chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install -y ./chrome.deb || apt --fix-broken install -y
rm chrome.deb

echo "🌍 Chrome instalado: $(google-chrome --version)"

echo "⬇️ Instalando ChromeDriver correspondiente..."
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+')
CHROMEDRIVER_VERSION=$(curl -sS "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
curl -sS -o chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
unzip chromedriver.zip
install -m 755 chromedriver /usr/local/bin/chromedriver
rm chromedriver.zip chromedriver

echo "🐍 Instalando dependencias Python..."
pip3 install -U pip selenium

echo "🚀 Iniciando bots..."
for i in $(seq 1 3); do
  echo "🟢 Iniciando Bot $i"
  python3 kick_view.py $i &
  sleep 2
done

wait
