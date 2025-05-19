FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias del sistema y herramientas necesarias
RUN apt-get update && apt-get install -y \
    wget curl unzip gnupg ca-certificates \
    libnss3 libxss1 libatk-bridge2.0-0 libgtk-3-0 libdrm2 libgbm1 libxshmfence1 \
    libxkbcommon0 libasound2 libx11-xcb1 libxcb-dri3-0 libxcomposite1 libxcursor1 \
    libxdamage1 libxi6 libxtst6 fonts-liberation \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Instala Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Obtiene la versión de Chrome
RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
    echo "Chrome version: $CHROME_VERSION" && \
    CHROMEDRIVER_VERSION=$(wget -qO- "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") && \
    wget -O chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip chromedriver.zip && \
    mv chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver.zip

# Añade Chrome y Chromedriver al PATH
ENV PATH="/usr/local/bin:/usr/bin:$PATH"

# Instala dependencias de Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia tu código de bot
COPY . /app
WORKDIR /app

# Comando por defecto
CMD ["python", "kick_view.py", "1"]
