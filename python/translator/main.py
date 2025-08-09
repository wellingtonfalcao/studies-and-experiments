import asyncio
import os
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
    print(f"Tradução finalizada com sucesso. Arquivo salvo em {arquivo_saida}\n\n")

def solicitar_arquivo():
    while True:
        nome_arquivo = input("Digite o nome do arquivo (somente o nome, sem caminho): ").strip()
        caminho_arquivo = os.path.join("conversion", nome_arquivo)

        if os.path.isfile(caminho_arquivo):
            confirmar = input(f"O arquivo '{nome_arquivo}' foi encontrado na pasta /conversion. Deseja usar este arquivo? (y/n): ").lower()
            if confirmar == 'y':
                return caminho_arquivo
            else:
                print("Vamos tentar novamente.")
        else:
            print(f"Arquivo '{nome_arquivo}' não encontrado na pasta /conversion. Tente novamente.")

if __name__ == "__main__":
    arquivo_entrada = solicitar_arquivo()
    nome_saida = os.path.basename(arquivo_entrada)
    caminho_saida = os.path.join("final", nome_saida)
    asyncio.run(traduzir_arquivo_em_pedacos(arquivo_entrada, caminho_saida))
