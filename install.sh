#!/bin/bash

source "./common/colors.sh"
source "./common/functions.sh"

# Detecta o sistema operacional
detect_os

echo_info "Starting installation for $OS..."

# Diretório onde o script foi clonado
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
        ./windows/convert2mp4.bat
        ;;
    *)
        echo_error "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo_success "Installation completed for $OS."
