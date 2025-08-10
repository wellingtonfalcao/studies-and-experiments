import subprocess
import sys
import os
import asyncio
import edge_tts

# Instala automaticamente o edge-tts se não estiver instalado
try:
    import edge_tts
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "edge-tts"])
    import edge_tts


INPUT_DIR = "input-text"
OUTPUT_DIR = "output-audio"
VOICE = "pt-BR-AntonioNeural"


async def processar_arquivo(txt_file):
    """Converte um arquivo de texto em áudio usando edge-tts."""
    nome_base = os.path.splitext(os.path.basename(txt_file))[0]
    mp3_file = os.path.join(OUTPUT_DIR, f"{nome_base}.mp3")

    # Verifica se já existe para evitar sobrescrever
    if os.path.exists(mp3_file):
        print(f"[PULAR] {mp3_file} já existe. Ignorando...")
        return

    print(f"[LER] {txt_file}")
    with open(txt_file, "r", encoding="utf-8") as f:
        texto = f.read().strip()

    if not texto:
        print(f"[AVISO] {txt_file} está vazio. Ignorando...")
        return

    print(f"[CONVERTENDO] {txt_file} -> {mp3_file}")
    tts = edge_tts.Communicate(texto, VOICE)
    await tts.save(mp3_file)
    print(f"[OK] Áudio salvo: {mp3_file}")


async def main():
    # Garante que as pastas existem
    os.makedirs(INPUT_DIR, exist_ok=True)
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Lista arquivos de texto
    arquivos_txt = [os.path.join(INPUT_DIR, f) for f in os.listdir(INPUT_DIR) if f.lower().endswith(".txt")]

    if not arquivos_txt:
        print(f"Nenhum arquivo .txt encontrado na pasta '{INPUT_DIR}'.")
        return

    print(f"Encontrados {len(arquivos_txt)} arquivos para processar.")

    # Processa em fila (um por vez)
    for arquivo in arquivos_txt:
        await processar_arquivo(arquivo)


if __name__ == "__main__":
    asyncio.run(main())
