FROM ubuntu:20.04

# Configurar variáveis de ambiente
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo
ENV PYTHONUNBUFFERED=1

# Configurar mirrors do apt e instalar dependências em uma única camada
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    git \
    curl \
    tzdata \
    ca-certificates \
    openssl \
    && update-ca-certificates \
    && ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Criar e configurar diretório da aplicação
WORKDIR /app

# Copiar e instalar requirements primeiro (aproveitamento de cache)
COPY requirements.txt .
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel && \
    pip3 install --no-cache-dir -r requirements.txt

# Copiar arquivos de configuração
COPY .env .env
COPY git-setup.sh ./git-setup.sh
RUN chmod +x ./git-setup.sh

# Copiar o resto do código
COPY . .

# Configurar Git com permissões mais amplas
RUN git config --global user.name "ribeirosilvarafaela" && \
    git config --global user.email "ribeiro_rafaelas@outlook.com" && \
    git config --global --add safe.directory /app && \
    git config --global credential.helper store

# Configurar entrypoint
ENTRYPOINT ["./git-setup.sh"]
