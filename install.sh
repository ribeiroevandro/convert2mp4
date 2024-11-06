#!/bin/bash

# Define o diretório base como o diretório deste script (absoluto e consistente)
base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verifica se o diretório `common` existe
if [ ! -d "$base_dir/common" ]; then
    echo "[ERROR] The common directory was not found in $base_dir"
    echo "Make sure you are running install.sh from within the project's root directory."
    exit 1
fi

# Importa arquivos de funções e cores
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

# Lógica de instalação com base no sistema operacional detectado
case "$OS" in
    "macOS"|"Linux")
        # Define o script principal como executável e cria link simbólico
        chmod +x "$config_dir/convert2mp4.sh"

        if [ -d "/usr/local/bin" ]; then
            echo_info "Creating symbolic link at /usr/local/bin/convert2mp4..."
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
    *)
        echo_error "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo_success "Installation completed for $OS."
