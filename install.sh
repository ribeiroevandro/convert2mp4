#!/bin/bash

# Funções de cores
function echo_error() {
  echo -e "\033[31m[ERROR]\033[0m $1"
}

function echo_success() {
  echo -e "\033[32m[SUCCESS]\033[0m $1"
}

function echo_warning() {
  echo -e "\033[33m[WARNING]\033[0m $1"
}

function echo_info() {
  echo -e "\033[34m[INFO]\033[0m $1"
}

# Definir a versão
VERSION=$(cat "$HOME/.config/convert2mp4/VERSION")

# Diretorio de instalação
INSTALL_DIR="$HOME/.config/convert2mp4"
BIN_DIR="/usr/local/bin"

echo_info "Starting installation of convert2mp4 version $VERSION..."

# Verificar se o diretório já existe
if [[ -d "$INSTALL_DIR" ]]; then
  echo_warning "Directory $INSTALL_DIR already exists, skipping git clone."
else
  # Clonar o repositório
  echo_info "Cloning the repository..."
  git clone https://github.com/ribeiroevandro/convert2mp4.git "$INSTALL_DIR"
fi

# Navegar até o diretório do projeto
cd "$INSTALL_DIR" || exit

# Verificar se o arquivo convert2mp4.sh existe
if [[ ! -f "$INSTALL_DIR/convert2mp4.sh" ]]; then
  echo_error "convert2mp4.sh script not found in the repository. Exiting installation."
  exit 1
fi

# Criar link simbólico no /usr/local/bin
echo_info "Creating symbolic link in $BIN_DIR..."
sudo ln -sf "$INSTALL_DIR/convert2mp4.sh" "$BIN_DIR/convert2mp4"

# Atualizar o terminal
echo_success "Installation complete. The convert2mp4 command is now available."

# Recarregar o shell para aplicar as mudanças
echo_info "Reopening the shell session..."
exec $SHELL -l