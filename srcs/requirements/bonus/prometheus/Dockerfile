FROM debian:buster

# Instalar pacotes necessários
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Copiar o script de configuração para a imagem
COPY /tools/setup.sh /tmp/setup.sh

# Executar o script de configuração
RUN chmod +x /tmp/setup.sh && /tmp/setup.sh

# Baixar e extrair Prometheus
RUN curl -fsSL "https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz" -o /tmp/prometheus.tar.gz \
    && tar xzf /tmp/prometheus.tar.gz --strip-components=1 -C /tmp \
    && mv /tmp/prometheus /usr/local/bin/ \
    && mv /tmp/promtool /usr/local/bin/ \
    && mv /tmp/prometheus.yml /etc/prometheus/prometheus.yml \
    && rm -rf /tmp/prometheus.tar.gz /tmp/prometheus-*

# Copiar o script de inicialização para a imagem
COPY /tools/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Expor porta do Prometheus
EXPOSE 9090

# Definir usuário para rodar o container
USER prometheus

# Definir o script de inicialização como ponto de entrada
ENTRYPOINT ["/usr/local/bin/start.sh"]