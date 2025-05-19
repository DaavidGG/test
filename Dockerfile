# Imagen base con Python
FROM python:3.11-slim

# Evita prompts interactivos al instalar
ENV DEBIAN_FRONTEND=noninteractive

# Instalación de dependencias del sistema
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    libnss3 \
    libxss1 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libdrm2 \
    libgbm1 \
    libxshmfence1 \
    fonts-liberation \
    libxkbcommon0 \
    libasound2 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Descargar e instalar Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Añadir Chrome al PATH por si acaso
ENV PATH="/usr/bin/google-chrome:$PATH"

# Instalar Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copiar el código del bot
COPY . /app
WORKDIR /app

# Comando por defecto para iniciar un bot (puedes pasar argumentos)
CMD ["python", "kick_view.py", "1"]
