#!/bin/bash

# Função para verificar se o ffmpeg está instalado
function check_ffmpeg_installed() {
  # Verifica se o comando ffmpeg existe
  if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed."
    # Carrega o arquivo os_instructions.sh para exibir instruções de instalação
    source os_instructions.sh
    display_install_instructions
    exit 1
  fi
}
