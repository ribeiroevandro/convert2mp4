#!/bin/bash

# Define o diretório base como o diretório deste script
base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Importa arquivos de funções e cores do diretório comum
if [ -f "$base_dir/common/colors.sh" ]; then
    source "$base_dir/common/colors.sh"
else
    echo "[ERROR] colors.sh not found in $base_dir/common"
    exit 1
fi

if [ -f "$base_dir/common/functions.sh" ]; then
    source "$base_dir/common/functions.sh"
else
    echo "[ERROR] functions.sh not found in $base_dir/common"
    exit 1
fi

# Detecta o sistema operacional
detect_os

echo_info "Starting installation for $OS..."

# Define o diretório de configuração para o script
config_dir="$HOME/.config/convert2mp4"

# Verifica o sistema operacional e realiza a instalação conforme necessário
case "$OS" in
    "macOS"|"Linux")
        # Torna o script principal executável
        chmod +x "$config_dir/convert2mp4.sh"

        # Cria o link simbólico em /usr/local/bin
        if [ -d "/usr/local/bin" ]; then
            echo_info "Creating symbolic link for $OS at /usr/local/bin/convert2mp4..."
            sudo ln -sf "$config_dir/convert2mp4.sh" "/usr/local/bin/convert2mp4"
            echo_success "Symbolic link created at /usr/local/bin/convert2mp4"
        else
            echo_error "Directory /usr/local/bin does not exist or is not accessible."
            exit 1
        fi
        ;;
    "Windows")
        # Executa o script para Windows
        "$base_dir/windows/convert2mp4.bat"
        ;;
   
