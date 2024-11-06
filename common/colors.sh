#!/bin/bash

# Define funções para exibir mensagens coloridas
if [[ "$OS" == "Windows" ]]; then
    echo_info() { echo "[INFO] $1"; }
    echo_success() { echo "[SUCCESS] $1"; }
    echo_error() { echo "[ERROR] $1"; }
else
    echo_info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
    echo_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
    echo_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }
fi
