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

# Ler a versão do arquivo VERSION
VERSION=$(cat "$HOME/.config/convert2mp4/VERSION")

# Função para obter a versão mais recente do repositório
function get_latest_version() {
  latest_version=$(curl -s https://api.github.com/repos/ribeiroevandro/convert2mp4/releases/latest | jq -r .tag_name)
  
  # Verificar se a versão mais recente foi obtida corretamente
  if [[ "$latest_version" == "null" ]]; then
    echo_error "Unable to fetch the latest version from the repository."
    exit 1
  fi

  echo "$latest_version"
}

# Verificar se a flag de versão foi chamada
if [[ "$1" == "--version" || "$1" == "-v" ]]; then
  echo "$VERSION"
  exit 0
fi

# Obter a versão mais recente do repositório
latest_version=$(get_latest_version)

# Comparar versões apenas se necessário
if [[ "$VERSION" != "$latest_version" ]]; then
  echo_warning "A new version ($latest_version) is available. You are currently using version $VERSION."
  should_update=true
else
  echo_info "You are using the latest version: $VERSION."
  should_update=false
fi

# Diretório da Desktop na raiz do usuário
desktop_dir="$HOME/Desktop"

# Verificar se o arquivo de entrada foi fornecido
if [[ -z "$1" ]]; then
  echo_error "No input file specified."
  exit 1
fi

# Nome do arquivo de entrada sem a extensão
input_file_base="$desktop_dir/$1"

# Adicionar a extensão .mov se o arquivo não tiver
input_file="$input_file_base.mov"

# Debug: Exibir caminho completo do arquivo de entrada
echo_info "Looking for input file in: $input_file"

# Verificar se o arquivo de entrada existe na pasta Desktop
if [[ ! -f "$input_file" ]]; then
  echo_error "Input file '$1.mov' does not exist in the Desktop directory."
  exit 1
fi

# Verificar se o ffmpeg está instalado
if ! command -v ffmpeg &> /dev/null; then
  echo_error "ffmpeg is not installed. Please install ffmpeg and try again."
  exit 1
fi

# Realizar a conversão usando ffmpeg
ffmpeg -i "$input_file" -c:v libx264 -crf 24 -r 40/1 -c:a aac -strict experimental "$desktop_dir/$2.mp4"

if [[ $? -eq 0 ]]; then
  echo_success "Conversion successful: '$2.mp4' has been saved to Desktop."
else
  echo_error "Error: Conversion failed."
  exit 1
fi

# Aviso final sobre a versão (apenas se houver uma nova versão)
if [[ "$should_update" == true ]]; then
  echo_warning "Remember to update to the latest version ($latest_version)."
fi
