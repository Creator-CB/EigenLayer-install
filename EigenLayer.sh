#!/bin/bash

function colors {
  GREEN="\e[32m"
  RED="\e[39m"
  YELLOW="\e[33m"
  NORMAL="\e[0m"
}

function logo {
  curl -s https://raw.githubusercontent.com/Creator-CB/FILES/main/TDM-Crypto.sh | bash
}

function line {
  echo -e "${RED}-----------------------------------------------------------------------------${NORMAL}"
}

function install_go {
    sudo apt-get update -y && sudo apt-get upgrade -y && wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && sudo tar -C $HOME/ -xzf go1.13.5.linux-amd64.tar.gz && cd $HOME/ && echo $PATH 

    sudo apt update
    sudo apt upgrade
    wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
    sudo tar -C $HOME/ -xzf go1.13.5.linux-amd64.tar.gz
    cd $HOME/
    echo $PATH

    echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.profile
    echo 'export PATH=$PATH:$HOME/bin' >> $HOME/.profile

    source $HOME/.profile

    apt install golang-go
    go version
}

function install_docker {
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    docker run hello-world
}

function install_eigenlayer {
    cd $HOME
    curl -sSfL https://raw.githubusercontent.com/layr-labs/eigenlayer-cli/master/scripts/install.sh | sh -s
    export PATH=$PATH:$HOME/bin
    eigenlayer operator keys create --key-type ecdsa name
    eigenlayer operator keys create --key-type bls name
}

function eigenda_setup {
    cd $HOME
    git clone https://github.com/Layr-Labs/eigenda-operator-setup.git
    cd eigenda-operator-setup
    cp .env.example .env
}

function main {
    colors
    logo
    install_go
    install_docker
    install_eigenlayer
    eigenda_setup
}

main

