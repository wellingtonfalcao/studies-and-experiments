import os
import shutil
import subprocess

def obter_diretorio_entrada():
    while True:
        dir_entrada = input("Digite o caminho da pasta onde estão os arquivos .mp4: ").strip()
        if os.path.isdir(dir_entrada):
            return os.path.abspath(dir_entrada)
        else:
            print("Diretório não encontrado. Tente novamente.")

def main():
    input_dir = obter_diretorio_entrada()
    print(f"\nProcessando arquivos em: {input_dir}\n")

    arquivos_mp4 = [f for f in os.listdir(input_dir) if f.lower().endswith('.mp4')]

    if not arquivos_mp4:
        print("Nenhum arquivo .mp4 encontrado no diretório.")
        return

    total = len(arquivos_mp4)
    for i, arquivo in enumerate(arquivos_mp4, 1):
        nome_sem_extensao = os.path.splitext(arquivo)[0]
        output_dir = os.path.join(input_dir, nome_sem_extensao)

        if not os.path.exists(output_dir):
            os.mkdir(output_dir)

        origem = os.path.join(input_dir, arquivo)
        destino = os.path.join(output_dir, arquivo)

        shutil.move(origem, destino)

        print(f"[{i}/{total}] Processando: {arquivo}")

        comando = [
            "whisper",
            destino,
            "--model", "medium",
            "--device", "cuda",
            "--language", "pt",
            "--output_dir", output_dir
        ]

        processo = subprocess.Popen(
            comando, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True
        )

        # Exibe saída em tempo real
        while True:
            linha = processo.stdout.readline()
            if linha == '' and processo.poll() is not None:
                break
            if linha:
                print(linha.strip())

        if processo.returncode == 0:
            print(f"Transcrição concluída para {arquivo}. Os arquivos foram salvos em: {output_dir}\n")
        else:
            print(f"Erro ao processar {arquivo}.\n")

    print("Todos os arquivos .mp4 foram processados!")

if __name__ == "__main__":
    main()
