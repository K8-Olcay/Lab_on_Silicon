FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y --no-install-recommends \
    nmap \
    curl \
    sqlmap \
    hydra \
    nikto \
    dirb \
    netcat-openbsd \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]