# Documentação do Instalador Dinâmico via Winget

## 📋 Visão Geral
Script desenvolvido por **Wellington Falcão** para automatizar a instalação de programas usando **Winget**, com sistema de categorias dinâmico baseado em arquivos de texto.

**GitHub:** github.com/wellingtonfalcao  
**Data:** 20/11/2025

---

## 🚀 Como Usar

### 1. Pré-requisitos
- Windows 10 ou 11  
- Winget instalado (vem por padrão nas versões recentes do Windows)  
- Permissões de administrador (recomendado)

---

### 2. Estrutura de Arquivos

diretorio_do_script/
├── instalador.bat # Script principal
├── games.txt # Categoria de jogos
├── dev.txt # Ferramentas de desenvolvimento
├── office.txt # Aplicativos de escritório
└── multimidia.txt # Aplicativos de mídia

yaml
Copiar código

---

### 3. Formato dos Arquivos de Categoria

Cada arquivo `.txt` deve conter **IDs válidos do Winget**, um por linha.

**Exemplo: `dev.txt`**

Microsoft.VisualStudioCode
Git.Git
OpenJS.NodeJS
Python.Python.3
JetBrains.IntelliJIDEA.Community

yaml
Copiar código

---

### 4. Como Encontrar IDs do Winget

#### Método 1: Pesquisar no Winget
winget search "nome do programa"

shell
Copiar código

#### Método 2: Listar programas instalados
winget list

yaml
Copiar código

#### Método 3: Site oficial
Acesse: https://winget.run/

---

### 5. Execução

1. Coloque o script em uma pasta  
2. Crie seus arquivos `.txt` com os programas desejados  
3. Execute como administrador (recomendado):

instalador.bat

yaml
Copiar código

---

## 📁 Exemplos de Categorias Prontas

### 🎮 `games.txt`
Valve.Steam
EpicGames.EpicGamesLauncher
GOG.Galaxy
Ubisoft.Connect
RiotGames.LeagueOfLegends

shell
Copiar código

### 💼 `office.txt`
Microsoft.Office
Adobe.Acrobat.Reader.64-bit
LibreOffice.LibreOffice
SumatraPDF.SumatraPDF

shell
Copiar código

### 🎵 `multimidia.txt`
VideoLAN.VLC
Spotify.Spotify
KodiFoundation.Kodi
Audacity.Audacity

shell
Copiar código

### 🔧 `utilities.txt`
7zip.7zip
CPUID.CPU-Z
CrystalDewWorld.CrystalDiskInfo
Piriform.Speccy

yaml
Copiar código

---

## 🎯 Fluxo de Operação

- **Menu Dinâmico:** O script lista automaticamente todas as categorias disponíveis  
- **Seleção:** Escolha uma categoria ou "INSTALAR TODAS"  
- **Instalação:** Cada programa é instalado sequencialmente  
- **Relatório:** Resultado detalhado com sucessos, já instalados e erros  

---

## ⚙️ Códigos de Status

- **[SUCESSO]:** Programa instalado corretamente  
- **[JA INSTALADO]:** Programa já existe no sistema  
- **[ERRO]:** Falha na instalação (verifique o ID ou conexão)  

---

## 🔄 Personalização

### Adicionar Nova Categoria
1. Crie um novo arquivo `.txt`  
2. Adicione IDs dos programas (um por linha)  
3. Execute o script — a categoria aparecerá automaticamente  

### Modificar Categoria Existente
- Edite o arquivo `.txt` correspondente  
- Adicione, remova ou altere IDs  
- Salve e execute novamente  

### Remover Categoria
- Delete o arquivo `.txt` correspondente  
- A categoria desaparecerá do menu  

---

## 🛠️ Solução de Problemas

### ❌ Erro: "No installed package found"
- ID incorreto  
- Use `winget search` para confirmar o ID

### ❌ Erro: "Access denied"
- Execute como administrador  
- Verifique permissões

### ❌ Erro: "Winget is not recognized"
- Atualize o Windows  
- Instale o **App Installer** da Microsoft Store  

---

## 💡 Dicas

- Teste IDs antes de adicionar  
- Mantenha backup dos arquivos  
- Atualize os IDs periodicamente  
- Crie categorias específicas por projeto  

---

## 📝 Exemplo de Uso Avançado

### Para Equipes de Desenvolvimento
dev_frontend.txt
dev_backend.txt
dev_database.txt
dev_tools.txt

shell
Copiar código

### Para Configuração de Novos PCs
essenciais.txt
desenvolvimento.txt
jogos.txt
produtividade.txt

yaml
Copiar código

---

## 🔒 Observações de Segurança
- Sempre verifique os IDs antes da instalação  
- Use apenas fontes confiáveis  
- O script apenas instala programas do repositório oficial do Winget  

---

## ✍️ Autor
**Wellington Falcão**  
GitHub: github.com/wellingtonfalcao  
Data: 20/11/2025

---

## 📞 Suporte
Em caso de problemas, verifique os IDs dos programas e execute o script como administrador.