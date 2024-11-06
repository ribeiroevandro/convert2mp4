#!/bin/bash

# Função que encontra o diretório base, percorrendo a árvore de diretórios
find_base_dir() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -d "$dir/common" ]]; then
            echo "$dir"
            return
        fi
        dir="$(dirname "$dir")"
    done
    echo "[ERROR] The common directory was not found."
    echo "Make sure you are running the script from the project's root directory."
    exit 1
}

# Define o diretório base do projeto chamando a função find_base_dir
base_dir=$(find_base_dir)

# Exibe o diretório onde a busca terminou
echo "[INFO] Base directory found: $base_dir"

# Verifica se o diretório common existe dentro do diretório base
if [ -d "$base_dir/common" ]; then
    echo "[INFO] Found 'common' directory."
else
    echo "[ERROR] 'common' directory not found in $base_dir"
    exit 1
fi

# Importa arquivos de funções e cores do diretório common
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

# Detecta o sistema operacional usando a função carregada
detect_os

# Exibe uma mensagem de início da instalação
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
    *)
        echo_error "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo_success "Installation completed for $OS."
