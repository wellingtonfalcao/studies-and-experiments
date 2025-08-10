# Instalação do Transcriber

````markdown
# Script de Transcrição com Whisper

## Requisitos

1. **Python 3.7+** instalado no sistema  
2. **Pacote Whisper** para Python:  
   Rode no terminal:  
   ```bash
   pip install openai-whisper
````

3. **FFmpeg** instalado e disponível no PATH

   * Windows: Baixe em [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html) e adicione o binário ao PATH
   * Linux (Debian/Ubuntu):

     ```bash
     sudo apt update
     sudo apt install ffmpeg
     ```
4. **Whisper CLI** instalado e disponível no PATH

   * Se você instalou o pacote via pip, talvez precise instalar a interface CLI separadamente ou usar o script Python diretamente.

## Como rodar

1. Coloque seus arquivos `.mp4` na pasta desejada
2. Execute o script Python:

   ```bash
   python seu_script.py
   ```
3. Informe o caminho da pasta onde estão os arquivos quando solicitado

## Dicas

* Se faltar algum programa, o script avisará o que instalar.
* Para ajuda com instalação do FFmpeg e Whisper, consulte os links oficiais.

---

# Script de verificação (exemplo básico)

```python
import sys
import shutil

def checar_pacote(nome):
    try:
        __import__(nome)
        print(f"Pacote '{nome}' encontrado.")
    except ImportError:
        print(f"Pacote '{nome}' NÃO encontrado. Rode: pip install {nome}")
        sys.exit(1)

def checar_comando(nome):
    if shutil.which(nome) is None:
        print(f"Comando '{nome}' NÃO encontrado no PATH. Instale-o e certifique-se que está disponível no PATH.")
        sys.exit(1)
    else:
        print(f"Comando '{nome}' encontrado.")

def main():
    print("Checando ambiente...\n")

    checar_pacote("whisper")   # exemplo, use o pacote que seu script precisa
    checar_comando("whisper")
    checar_comando("ffmpeg")

    print("\nTudo pronto para rodar seu script!")

if __name__ == "__main__":
    main()

