#!/bin/bash

# Carregar variáveis de ambiente (opcional)
if [ -z "$CONFIG_FILE" ]; then
  CONFIG_FILE="/etc/prometheus/prometheus.yml"
fi

if [ -z "$STORAGE_PATH" ]; then
  STORAGE_PATH="/var/lib/prometheus"
fi

# Validar se o arquivo de configuração existe
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Erro: Arquivo de configuração do Prometheus não encontrado em $CONFIG_FILE"
  exit 1
fi

# Validar se o diretório de armazenamento existe
if [ ! -d "$STORAGE_PATH" ]; then
  echo "Erro: Diretório de armazenamento do Prometheus não encontrado em $STORAGE_PATH"
  exit 1
fi

# Iniciar o Prometheus
echo "Iniciando Prometheus com o arquivo de configuração $CONFIG_FILE e armazenamento em $STORAGE_PATH..."
exec /usr/local/bin/prometheus \
  --config.file="$CONFIG_FILE" \
  --storage.tsdb.path="$STORAGE_PATH"