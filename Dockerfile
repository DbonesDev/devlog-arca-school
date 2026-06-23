FROM --platform=linux/amd64 ubuntu:24.04

ARG ZOLA_VERSION=0.19.2

RUN apt-get update && apt-get install -y curl && \
    curl -sL "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" | tar xz -C /usr/local/bin && \
    apt-get remove -y curl && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

WORKDIR /site
EXPOSE 1111

CMD ["zola", "serve", "--interface", "0.0.0.0", "--port", "1111"]
