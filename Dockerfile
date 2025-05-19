FROM python:3.11-slim

# Evita interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instala Chrome
RUN apt-get update && apt-get install -y \
    wget unzip gnupg curl xvfb \
    libglib2.0-0 libnss3 libgconf-2-4 libfontconfig1 libxss1 libappindicator1 libindicator7 libu2f-udev \
    fonts-liberation libatk-bridge2.0-0 libgtk-3-0 libdrm-dev libxcomposite1 libxrandr2 libxdamage1 libxkbcommon0 \
    --no-install-recommends && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala pip y dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el script
COPY kick_view.py .

# Lanza el bot
CMD ["python", "kick_view.py"]
