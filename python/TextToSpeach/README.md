# 📖 Text-to-Speech Converter with Edge TTS

**🌐 Language:** [🇧🇷 Português](#-conversor-automático-de-texto-para-áudio-com-edge-tts) | **[🇺🇸 English](#-automatic-text-to-speech-converter-with-edge-tts)**

---

## 🇺🇸 Automatic Text-to-Speech Converter with Edge TTS

This script automatically converts all `.txt` files from an input folder into `.mp3` audio files using **Microsoft Edge Text-to-Speech**.
Perfect for creating audiobooks, narrations, and audio content quickly and easily.

---

### 💡 Motivation

I created this script to help me with my studies and leisure time, such as during walks, while driving, or even when playing games like **Cities: Skylines** or **Age of Empires**.
I needed to generate audio versions of the books I study at college (especially the more theoretical ones), so I developed this Python application to solve my problem — and it was very effective.

I believe I will make improvements for my personal use in the future, but I’m sharing it here because I think it can be very useful for others who also need to study in our fast-paced daily lives.

---

### 📂 Folder Structure

```
.
├── script.py          # Main code
├── input-text/        # Place your .txt input files here
└── output-audio/      # Generated .mp3 audio files will be saved here
```

---

### 🛠 Requirements

* **Python 3.8+**
* Internet connection
* [`edge-tts`](https://pypi.org/project/edge-tts/) library (auto-installs if missing)

---

### 🚀 How to Use

1. **Create folders**

   * Create an `input-text` folder in the same directory as the script.
   * Place all `.txt` files you want to convert inside it.

2. **Run the script**

   ```bash
   python script.py
   ```

3. **Output**

   * The audio files will be generated in the `output-audio` folder with the same name as the text file.
   * Existing `.mp3` files **will not be overwritten**.

---

### ⚙️ How It Works

1. The script automatically creates the required folders (`input-text` and `output-audio`).
2. Reads all `.txt` files in the input folder.
3. Converts each file to `.mp3` using the **"pt-BR-AntonioNeural"** voice.
4. Saves the audio file in the output folder, keeping the original file name.
5. Skips files that have already been converted.

---

### 🗣 Changing the Voice

The default voice is `"pt-BR-AntonioNeural"`, but you can change it to any supported by `edge-tts`.
To list all available voices, run:

```bash
edge-tts --list-voices
```

Then, update the variable in the code:

```python
VOICE = "pt-BR-AntonioNeural"
```

---

### 📌 Example

**Input** (`input-text/Chapter1.txt`):

```
Once upon a time, in a faraway kingdom...
```

**Output** (`output-audio/Chapter1.mp3`):

* An audio file narrating the text.

---

### 🙌 Credits

* **Author:** [Wellington Albuquerque Falcão](https://www.linkedin.com/in/wellingtonfalcao)
* **Inspiration & Tutorials:** [Geeky Script](https://www.youtube.com/@GeekyScript)
* **Libraries Used:**

  * [`edge-tts`](https://pypi.org/project/edge-tts/) – Microsoft Edge Text-to-Speech API
  * [`asyncio`](https://docs.python.org/3/library/asyncio.html) – Python async library

---

### 📜 License

This code is free to use and modify.

---

## 🇧🇷 Conversor Automático de Texto para Áudio com Edge TTS

Este script converte automaticamente todos os arquivos `.txt` de uma pasta em arquivos `.mp3` usando o serviço **Microsoft Edge Text-to-Speech**.
Ideal para criar audiolivros, narrações e conteúdo de áudio de forma rápida e prática.

---

### 💡 Motivação

Gerei este script com objetivo de me auxiliar nos estudos e momentos de lazer, como caminhadas, quando estou dirigindo ou mesmo jogando **Cities: Skylines** ou **Age of Empires**.
Precisava gerar áudios dos livros que preciso estudar na faculdade (principalmente os mais teóricos), então fiz essa aplicação em Python para resolver este meu problema — e foi muito efetivo.

Acredito que posteriormente farei melhorias para meu uso, então disponibilizo pois acredito que vá auxiliar muito quem precisa estudar nesse cotidiano tão corrido.

---

### 📂 Estrutura de Pastas

```
.
├── script.py          # Código principal
├── input-text/        # Coloque aqui os arquivos .txt de entrada
└── output-audio/      # Aqui serão salvos os arquivos .mp3 gerados
```

---

### 🛠 Requisitos

* **Python 3.8+**
* Conexão com a internet
* Biblioteca [`edge-tts`](https://pypi.org/project/edge-tts/) (instala automaticamente)

---

### 🚀 Como Usar

1. **Criar as pastas**

   * Crie uma pasta chamada `input-text` na mesma pasta do script.
   * Coloque dentro dela todos os arquivos `.txt` que deseja converter.

2. **Executar o script**

   ```bash
   python script.py
   ```

3. **Resultado**

   * Os áudios serão gerados na pasta `output-audio` com o mesmo nome do arquivo de texto.
   * Arquivos já convertidos **não serão sobrescritos**.

---

### ⚙️ Funcionamento

1. O script cria automaticamente as pastas necessárias (`input-text` e `output-audio`).
2. Lê todos os arquivos `.txt` na pasta de entrada.
3. Converte cada arquivo para `.mp3` usando a voz **"pt-BR-AntonioNeural"**.
4. Salva o áudio na pasta de saída, mantendo o nome original.
5. Ignora arquivos que já tenham sido convertidos anteriormente.

---

### 🗣 Alterando a Voz

O padrão é `"pt-BR-AntonioNeural"`, mas é possível trocar para qualquer voz suportada pelo `edge-tts`.
Para listar as vozes disponíveis, execute:

```bash
edge-tts --list-voices
```

Depois, altere no código a variável:

```python
VOICE = "pt-BR-AntonioNeural"
```

---

### 📌 Exemplo

**Entrada** (`input-text/Capitulo1.txt`):

```
Era uma vez, em um reino distante...
```

**Saída** (`output-audio/Capitulo1.mp3`):

* Arquivo de áudio narrando o texto.

---

### 🙌 Créditos

* **Autor:** [Wellington Albuquerque Falcão](https://www.linkedin.com/in/wellingtonfalcao)
* **Inspiração & Tutoriais:** [Geeky Script](https://www.youtube.com/@GeekyScript)
* **Bibliotecas Utilizadas:**

  * [`edge-tts`](https://pypi.org/project/edge-tts/) – API Microsoft Edge Text-to-Speech
  * [`asyncio`](https://docs.python.org/3/library/asyncio.html) – Biblioteca assíncrona do Python
