#!/bin/bash

# Função para exibir instruções de instalação do ffmpeg
function display_install_instructions() {
  echo "To use this script, ffmpeg must be installed. Here are the instructions based on your OS."

  case "$OSTYPE" in
    linux*)
      if [[ -f /etc/debian_version ]]; then
        echo "Debian/Ubuntu detected. To install ffmpeg, run:"
        echo "sudo apt update && sudo apt install ffmpeg"
      elif [[ -f /etc/redhat-release ]]; then
        echo "Red Hat/CentOS detected. To install ffmpeg, run:"
        echo "sudo yum install ffmpeg"
      else
        echo "Linux distribution not detected. Please refer to https://www.ffmpeg.org/download.html for installation instructions."
      fi
      ;;
    darwin*)
      echo "macOS detected. To install ffmpeg, run:"
      echo "brew install ffmpeg"
      ;;
    cygwin* | msys* | win32*)
      echo "Windows detected. Please download ffmpeg from https://www.ffmpeg.org/download.html"
      ;;
    *)
      echo "Unsupported operating system. Please refer to https://www.ffmpeg.org/download.html for installation instructions."
      ;;
  esac
}
