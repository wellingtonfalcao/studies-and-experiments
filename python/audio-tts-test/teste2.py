import torch
from TTS.api import TTS
import textwrap
import os

# Detecta GPU
device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Usando dispositivo: {device}")

# Carrega modelo que já fala português
tts = TTS(model_name="tts_models/multilingual/multi-dataset/your_tts", progress_bar=True).to(device)

# Voz padrão (pegará a primeira disponível no modelo)
voz_padrao = tts.speakers[0]
print(f"Voz escolhida: {voz_padrao}")

# Arquivo de entrada (livro em texto)
arquivo_livro = "livro.txt"  # Coloque seu livro .txt aqui

# Pasta de saída
pasta_saida = "audiolivro"
os.makedirs(pasta_saida, exist_ok=True)

# Lê o texto
with open(arquivo_livro, "r", encoding="utf-8") as f:
    texto = f.read()

# Quebra o texto em blocos menores (1500 caracteres por bloco)
blocos = textwrap.wrap(texto, 1500)

# Gera o áudio para cada bloco
for i, bloco in enumerate(blocos, start=1):
    arquivo_mp3 = os.path.join(pasta_saida, f"parte_{i}.mp3")
    print(f"Gerando: {arquivo_mp3}")
    tts.tts_to_file(
        text=bloco,
        speaker=voz_padrao,
        language="pt-br",
        file_path=arquivo_mp3
    )

print("\n✅ Audiolivro gerado com sucesso!")
print(f"Arquivos salvos em: {os.path.abspath(pasta_saida)}")
