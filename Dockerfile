FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

# Update sources list and install dependencies
RUN apt update && apt-get --no-install-recommends install -y \
    git \
    ca-certificates \
    curl && \
    apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/*

# Install nvm
ENV NVM_VERSION=0.40.1
ENV NVM_DIR=/usr/local/nvm

RUN mkdir $NVM_DIR && \
    curl -L -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash

# Install GB Studio
WORKDIR /usr/lib

ARG GBSTUDIO_VERSION
ENV GBSTUDIO_VERSION=$GBSTUDIO_VERSION

RUN source $NVM_DIR/nvm.sh \
    # clone gb-studio
    && git clone -b v$GBSTUDIO_VERSION https://github.com/chrismaltby/gb-studio.git gb-studio-$GBSTUDIO_VERSION \
    && cd gb-studio-$GBSTUDIO_VERSION \
    # build cli
    && nvm install $(cut -d. -f1 < .nvmrc) -b \
    && npm install -g yarn \
    && yarnpkg \
    && npm run make:cli \
    # link cli
    && yarnpkg link \
    && ln -s $NVM_BIN/node /usr/bin/node \
    && ln -s /usr/lib/gb-studio-$GBSTUDIO_VERSION/out/cli/gb-studio-cli.js /usr/bin/gb-studio-cli-$GBSTUDIO_VERSION \
    && chmod +x out/cli/gb-studio-cli.js \
    # confirm build
    && gb-studio-cli-$GBSTUDIO_VERSION --version \
    && gb-studio-cli --version \
    # clean
    && npm remove -g yarn

WORKDIR /home/ubuntu