#!/bin/bash

# Caminho do diretório de configuração
config_dir="$HOME/.config/convert2mp4"

# Verifica se a pasta do projeto existe
if [ ! -d "$config_dir" ]; then
  echo "Error: convert2mp4 directory does not exist. Please install it first."
  exit 1
fi

# Navega até a pasta do projeto
cd "$config_dir" || { echo "Error: Unable to navigate to $config_dir."; exit 1; }

# Faz um pull para atualizar o repositório
echo "Updating convert2mp4..."
git pull origin main

# Atualiza o link simbólico
script_path="$config_dir/convert2mp4.sh"
if [ -f "$script_path" ]; then
  # Remove o link simbólico antigo, se existir
  rm -f /usr/local/bin/convert2mp4
  # Cria um novo link simbólico
  echo "#!/bin/bash" | sudo tee /usr/local/bin/convert2mp4 > /dev/null
  echo "config_dir=\"\$HOME/.config/convert2mp4\"" | sudo tee -a /usr/local/bin/convert2mp4 > /dev/null
  echo "\$config_dir/convert2mp4.sh \"\$@\"" | sudo tee -a /usr/local/bin/convert2mp4 > /dev/null

  # Dê permissão de execução ao novo wrapper
  chmod +x /usr/local/bin/convert2mp4

  echo "convert2mp4 has been updated successfully."
else
  echo "Error: convert2mp4.sh script not found. Update failed."
  exit 1
fi
