import asyncio
import edge_tts


async def main():
    # Abre o arquivo e lê todo o conteúdo
    print("Iniciando leitura do arquivo...")
    with open("arquivo.txt", "r", encoding="utf-8") as f:
        texto = f.read()

    # Cria a comunicação com o texto lido
    print("Fazendo transcrição do texto para audio...")
    tts = edge_tts.Communicate(texto, "pt-BR-AntonioNeural")

    # Salva o áudio
    await tts.save("Teste.mp3")
    print("Conversão realizada com sucesso!")

asyncio.run(main())