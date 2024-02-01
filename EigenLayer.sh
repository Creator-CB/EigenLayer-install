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
  # Update and upgrade the system
  sudo apt-get update -y && sudo apt-get upgrade -y

  # Download and extract Go
  wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
  sudo tar -C $HOME/ -xzf go1.13.5.linux-amd64.tar.gz

  # Update environment variables
  echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.profile
  echo 'export PATH=$PATH:$HOME/bin' >> $HOME/.profile

  source $HOME/.profile

  # Install Golang
  sudo apt-get install -y golang-go
  go version
}

function install_docker {
  # Install Docker dependencies
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

  # Add Docker GPG key and repository
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install Docker
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose

  # Add the user to the docker group
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker

  # Test Docker installation
  docker run hello-world
}

function eigenda_setup {
  # Clone Eigenda setup repository
  cd $HOME
  git clone https://github.com/Layr-Labs/eigenda-operator-setup.git
  cd eigenda-operator-setup

  # Copy environment file
  cp .env.example .env

  cd $HOME
}

function install_eigenlayer {
  # Install Eigenlayer CLI
  cd $HOME
  curl -sSfL https://raw.githubusercontent.com/layr-labs/eigenlayer-cli/master/scripts/install.sh | sh -s
  source $HOME/.profile  # Ensure the changes take effect in the current session
  eigenlayer version  # Check Eigenlayer version
}

function main {
  colors
  logo
  install_go
  install_docker
  eigenda_setup
  install_eigenlayer 
}

main

