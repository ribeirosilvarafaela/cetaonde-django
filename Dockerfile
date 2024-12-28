FROM ubuntu:20.04

# Atualizar pacotes e instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    && apt-get clean

# Atualizar pip e setuptools
RUN pip3 install --upgrade pip setuptools

RUN apt update && apt install -y git

# Instalar dependências do projeto
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copiar o restante do código para o contêiner
COPY . /app
WORKDIR /app

# Definir o comando padrão do contêiner
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
