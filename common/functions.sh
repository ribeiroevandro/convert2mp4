#!/bin/bash

# Função para detectar o sistema operacional
detect_os() {
    case "$OSTYPE" in
        msys*|cygwin*) OS="Windows" ;;
        darwin*) OS="macOS" ;;
        linux*) OS="Linux" ;;
        *) OS="unknown" ;;
    esac
}

# Verifica se o ffmpeg está instalado
check_ffmpeg_installed() {
    if ! command -v ffmpeg &>/dev/null; then
        echo_error "ffmpeg is not installed. Please install ffmpeg for $OS."
        if [[ "$OS" == "Windows" ]]; then
            echo "Download from https://ffmpeg.org/download.html"
        else
            echo "Use your package manager, e.g., 'brew install ffmpeg' on macOS."
        fi
        return 1
    fi
}
