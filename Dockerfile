# Usar una imagen base oficial de Python
FROM python:3.11-slim

# Instalar Chromium y dependencias necesarias para Selenium
RUN apt-get update && apt-get install -y \
    chromium-driver \
    chromium \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Establecer la ubicación de Chrome/Chromium
ENV CHROME_PATH=/usr/bin/chromium
ENV PATH="/usr/bin:${PATH}"

# Crear directorio de trabajo
WORKDIR /app

# Copiar requirements primero para aprovechar la caché
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de la aplicación
COPY . .

# Comando para iniciar el servidor
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]