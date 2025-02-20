#!/bin/bash

# Criar usuário Prometheus
useradd --no-create-home --shell /bin/false prometheus

# Criar diretórios
mkdir -p /etc/prometheus /var/lib/prometheus

# Ajustar permissões
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus