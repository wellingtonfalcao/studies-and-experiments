import torch
from TTS.api import TTS
import os

device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Usando dispositivo: {device}")

tts = TTS(model_name="tts_models/multilingual/multi-dataset/your_tts", progress_bar=True).to(device)

voz_padrao = tts.speakers[0]
print(f"Voz escolhida: {voz_padrao}")

arquivo_livro = "livro.txt"
pasta_saida = "audiolivro"
os.makedirs(pasta_saida, exist_ok=True)

with open(arquivo_livro, "r", encoding="utf-8") as f:
    texto = f.read()

arquivo_mp3 = os.path.join(pasta_saida, "audiolivro_completo.mp3")
print(f"Gerando áudio em: {arquivo_mp3}")

# Parâmetros para deixar a voz mais natural
# speed: controle da velocidade (1.0 = normal)
# speaker_embedding: usar voz do speaker selecionado
# outros parâmetros do Coqui TTS podem ser testados conforme documentação

tts.tts_to_file(
    text=texto,
    speaker=voz_padrao,
    language="pt-br",
    file_path=arquivo_mp3,
    speed=1.1,          # acelerar um pouco para não ficar lento
    rate=1.5,
    # ajustes extras que ajudam:
    #put_accent=True,
    #put_yo=True,
)

print("\n✅ Audiolivro gerado com voz mais natural!")
