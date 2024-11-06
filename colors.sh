#!/bin/bash

# Definindo as cores para as mensagens
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'  # Reset color

# Funções para exibir mensagens coloridas
function echo_success() {
  echo -e "${GREEN}$1${RESET}"
}

function echo_error() {
  echo -e "${RED}$1${RESET}"
}

function echo_warning() {
  echo -e "${YELLOW}$1${RESET}"
}

function echo_info() {
  echo -e "${CYAN}$1${RESET}"
}
