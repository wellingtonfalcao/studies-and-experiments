import asyncio
from googletrans import Translator

def dividir_texto(texto, max_chars=4500):
    partes = []
    inicio = 0
    while inicio < len(texto):
        fim = inicio + max_chars
        if fim >= len(texto):
            partes.append(texto[inicio:])
            break
        else:
            ultimo_espaco = texto.rfind(" ", inicio, fim)
            if ultimo_espaco == -1:
                ultimo_espaco = fim
            partes.append(texto[inicio:ultimo_espaco])
            inicio = ultimo_espaco + 1
    return partes

async def traduzir_arquivo_em_pedacos(arquivo_entrada, arquivo_saida):
    translator = Translator()

    with open(arquivo_entrada, "r", encoding="utf-8") as f:
        texto = f.read()

    partes = dividir_texto(texto)
    resultado = []
    print("Iniciando tradução. Este processo poderá levar vários minutos.")
    for i, parte in enumerate(partes, 1):
        print(f"Traduzindo parte {i} de {len(partes)}...")
        traducao = await translator.translate(parte, src='en', dest='pt')
        resultado.append(traducao.text)
        await asyncio.sleep(1)

    texto_traduzido = "\n".join(resultado)

    with open(arquivo_saida, "w", encoding="utf-8") as f:
        f.write(texto_traduzido)
    print("Tradução finalizada com sucesso.\n\n")
if __name__ == "__main__":
    asyncio.run(traduzir_arquivo_em_pedacos("teste.txt", "texto_portugues.txt"))
