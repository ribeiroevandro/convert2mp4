#!/bin/bash

# Inclui cores e funções
source "$(dirname "$0")/common/colors.sh"
source "$(dirname "$0")/common/functions.sh"

# Detecta o sistema operacional e define o caminho
echo_info "Detecting operating system..."
detect_os

if [[ "$OS" == "Windows" ]]; then
    config_dir="$USERPROFILE/.config/convert2mp4"
else
    config_dir="$HOME/.config/convert2mp4"
fi

echo_info "Installing convert2mp4 to $config_dir..."

# Clona o repositório
if [[ ! -d "$config_dir" ]]; then
    mkdir -p "$config_dir"
    git clone https://github.com/ribeiroevandro/convert2mp4.git "$config_dir"
fi

# Cria link simbólico ou atalho
if [[ "$OS" == "Windows" ]]; then
    mklink "$config_dir/convert2mp4.bat" "convert2mp4.bat"  # Usa um script .bat para chamar o .sh
else
    ln -s "$config_dir/convert2mp4.sh" "/usr/local/bin/convert2mp4"
fi

echo_success "Installation completed successfully. Use 'convert2mp4 --version' to verify."
exec $SHELL -l  # Atualiza o terminal após a instalação
