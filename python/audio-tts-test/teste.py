import os
import textwrap
from TTS.api import TTS
from pydub import AudioSegment

# ===== CONFIGURAÇÕES =====
ARQUIVO_LIVRO = "livro.txt"      # Caminho para seu arquivo .txt
PASTA_SAIDA = "audiolivro"       # Pasta onde os MP3 serão salvos
BLOCO_CARACTERES = 3000          # Máximo de caracteres por bloco (para evitar travar)
JUNTAR_EM_UNICO_ARQUIVO = True   # True = cria um único MP3 final
MODELO_VOZ = "tts_models/multilingual/multi-dataset/your_tts"  # Modelo de voz

# Criar pasta de saída
os.makedirs(PASTA_SAIDA, exist_ok=True)

# Ler o texto do livro
with open(ARQUIVO_LIVRO, "r", encoding="utf-8") as f:
    texto = f.read()

# Dividir o texto em blocos menores
blocos = textwrap.wrap(texto, BLOCO_CARACTERES)

# Carregar modelo TTS com GPU
print("🚀 Carregando modelo na GPU...")
tts = TTS(model_name=MODELO_VOZ, progress_bar=False, gpu=True)

# Gerar um MP3 para cada bloco
arquivos_mp3 = []
for i, bloco in enumerate(blocos, start=1):
    arquivo_mp3 = os.path.join(PASTA_SAIDA, f"capitulo_{i}.mp3")
    print(f"🎙️ Gerando {arquivo_mp3}...")
    tts.tts_to_file(
    text=bloco,
    speaker="female-en-5",  # <-- Defina aqui
    language="pt-br",
    file_path=arquivo_mp3
)
    arquivos_mp3.append(arquivo_mp3)

# Juntar todos os capítulos em um único MP3
if JUNTAR_EM_UNICO_ARQUIVO:
    print("🔄 Juntando todos os capítulos em um único MP3...")
    audio_final = AudioSegment.empty()
    for mp3 in arquivos_mp3:
        audio_final += AudioSegment.from_mp3(mp3)
    audio_final.export(os.path.join(PASTA_SAIDA, "audiolivro_completo.mp3"), format="mp3")
    print("✅ Audiolivro completo gerado!")

print("🎉 Processo concluído!")