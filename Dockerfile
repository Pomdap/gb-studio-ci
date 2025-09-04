FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

# Update sources list and install dependencies
RUN apt update && apt-get --no-install-recommends install --assume-yes \
    git \
    ca-certificates \
    curl && \
    apt-get --assume-yes autoclean && \
    rm --recursive --force /var/lib/apt/lists/*

# Install nvm
ENV NVM_VERSION=0.40.1
ENV NVM_DIR=/usr/local/nvm

RUN mkdir $NVM_DIR && \
    curl --location --output - https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash

# Install GB Studio
WORKDIR /usr/lib

ARG GBSTUDIO_VERSION
ENV GBSTUDIO_VERSION=$GBSTUDIO_VERSION

RUN source $NVM_DIR/nvm.sh \
    # clone gb-studio
    && git clone --single-branch --branch v$GBSTUDIO_VERSION https://github.com/chrismaltby/gb-studio.git gb-studio \
    && cd gb-studio \
    # install dependencies
    && nvm install $(cut --delimiter='.' --fields=1 < .nvmrc) --reinstall-packages-from=current \
    && if [ -f ".yarnrc" ]; then \
        npm install --global corepack && \
        corepack enable; \
    else \
        npm install --global yarn; \
    fi \
    && yarn install \
    # build
    && npm run make:cli \
    # link cli
    && ln --symbolic $NVM_BIN/node /usr/bin/node \
    && ln --symbolic /usr/lib/gb-studio/out/cli/gb-studio-cli.js /usr/bin/gb-studio-cli \
    && chmod +x out/cli/gb-studio-cli.js \
    # confirm build
    && gb-studio-cli --version \
    # clean
    && npm remove --global yarn

WORKDIR /home/ubuntu