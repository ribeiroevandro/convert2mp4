#!/bin/bash

# Caminho para o arquivo de cores
source "$HOME/.config/convert2mp4/colors.sh"

# Função para desinstalar o convert2mp4
function uninstall_convert2mp4() {
  echo_info "Uninstalling convert2mp4..."

  # Remover o link simbólico
  if [[ -f /usr/local/bin/convert2mp4 ]]; then
    echo_warning "Removing symbolic link..."
    sudo rm /usr/local/bin/convert2mp4
    echo_success "Symbolic link removed."
  else
    echo_warning "No symbolic link found. Skipping."
  fi

  # Remover a pasta de configuração
  if [[ -d "$HOME/.config/convert2mp4" ]]; then
    echo_warning "Removing configuration directory..."
    rm -rf "$HOME/.config/convert2mp4"
    echo_success "Configuration directory removed."
  else
    echo_warning "No configuration directory found. Skipping."
  fi

  echo_success "Uninstallation complete."
}

# Executando a desinstalação
uninstall_convert2mp4
