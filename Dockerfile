FROM python:3.11-slim

# Instala dependencias básicas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    fonts-liberation \
    libnss3 \
    libxss1 \
    libxkbcommon0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libdrm2 \
    libgbm1 \
    libxshmfence1 \
    libasound2 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcb-xfixes0 \
    libxcomposite1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Añade llave GPG de Google y repositorio de Chrome
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Instala Google Chrome estable
RUN apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

# Debug: mostrar la ruta de chrome instalada
RUN which google-chrome

# Instala Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app

COPY kick_view.py /app/kick_view.py
COPY start_bots.sh /app/start_bots.sh

# Instalar dependencias, Chrome, chromedriver, Python, pip, etc. aquí

RUN chmod +x /app/start_bots.sh

CMD ["/app/start_bots.sh"]
