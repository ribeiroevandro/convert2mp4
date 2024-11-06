# **convert2mp4 - Documentação**

## **Visão Geral**

O `convert2mp4` é uma ferramenta simples para converter arquivos de vídeo `.mov` para o formato `.mp4`, usando o `ffmpeg`. O script verifica se o `ffmpeg` está instalado e também pode verificar se há uma versão mais recente disponível para o seu repositório no GitHub. Caso uma nova versão seja detectada, o usuário será avisado a atualizar a ferramenta.

## **Instalação**

<details>
  <summary>MacOS</summary>

### **Instalar via Script**
1. Para instalar o `convert2mp4`, execute o seguinte comando no terminal:

```bash
curl -L https://www.ribeiroevandro.com.br/convert2mp4/install | bash
```

2. O script realizará as seguintes etapas:
- Verificará se o sistema operacional é compatível.
- Verificará se o `ffmpeg` está instalado.
- Clonará o repositório `convert2mp4` na pasta `~/.config/convert2mp4`.
- Criará um link simbólico para o script `convert2mp4.sh` em `/usr/local/bin/`.
</details>

## **Uso**

```sh
convert2mp4 <input_file_name> <output_file_name>
```

- `<input_file_name>`: Nome do arquivo `.mov` (sem a extensão).
- `<output_file_name>`: Nome do arquivo de saída `.mp4`.