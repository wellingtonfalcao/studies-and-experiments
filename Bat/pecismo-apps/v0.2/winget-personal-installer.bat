@echo off
setlocal enabledelayedexpansion
title Instalador via Winget

:: Configurações
set "categoria_dir=."
set "extensao=.txt"

:: Verificar se existem arquivos de categoria
set /a count=0
for %%f in ("%categoria_dir%\*%extensao%") do (
    set /a count+=1
)

if !count! equ 0 (
    echo Nenhum arquivo de categoria encontrado!
    echo Criando arquivos de exemplo...
    
    echo Valve.Steam > "games.txt"
    echo EpicGames.EpicGamesLauncher >> "games.txt"
    echo GOG.Galaxy >> "games.txt"
    
    echo REALiX.HWiNFO > "hardware.txt"
    echo CPUID.CPU-Z >> "hardware.txt"
    echo CrystalDewWorld.CrystalDiskInfo >> "hardware.txt"
    
    echo Google.Chrome > "essenciais.txt"
    echo Mozilla.Firefox >> "essenciais.txt"
    echo VideoLAN.VLC >> "essenciais.txt"
    
    echo Microsoft.VisualStudioCode > "dev.txt"
    echo Git.Git >> "dev.txt"
    echo OpenJS.NodeJS >> "dev.txt"
    
    echo.
    echo Arquivos de exemplo criados. Pressione qualquer tecla para continuar...
    pause >nul
)

:menu
cls
echo =============================================
echo       Instalador de Programas via Winget
echo =============================================
echo.

:: Gerar menu dinâmico
set /a opcao_num=1
set "opcoes="

echo Selecione uma categoria para instalar:
echo.

:: Listar arquivos .txt e criar opções do menu
for %%f in ("%categoria_dir%\*%extensao%") do (
    set "arquivo=%%~nf"
    
    :: Converter nome do arquivo para maiúsculas
    set "categoria_nome=!arquivo!"
    set "categoria_nome=!categoria_nome:a=A!"
    set "categoria_nome=!categoria_nome:b=B!"
    set "categoria_nome=!categoria_nome:c=C!"
    set "categoria_nome=!categoria_nome:d=D!"
    set "categoria_nome=!categoria_nome:e=E!"
    set "categoria_nome=!categoria_nome:f=F!"
    set "categoria_nome=!categoria_nome:g=G!"
    set "categoria_nome=!categoria_nome:h=H!"
    set "categoria_nome=!categoria_nome:i=I!"
    set "categoria_nome=!categoria_nome:j=J!"
    set "categoria_nome=!categoria_nome:k=K!"
    set "categoria_nome=!categoria_nome:l=L!"
    set "categoria_nome=!categoria_nome:m=M!"
    set "categoria_nome=!categoria_nome:n=N!"
    set "categoria_nome=!categoria_nome:o=O!"
    set "categoria_nome=!categoria_nome:p=P!"
    set "categoria_nome=!categoria_nome:q=Q!"
    set "categoria_nome=!categoria_nome:r=R!"
    set "categoria_nome=!categoria_nome:s=S!"
    set "categoria_nome=!categoria_nome:t=T!"
    set "categoria_nome=!categoria_nome:u=U!"
    set "categoria_nome=!categoria_nome:v=V!"
    set "categoria_nome=!categoria_nome:w=W!"
    set "categoria_nome=!categoria_nome:x=X!"
    set "categoria_nome=!categoria_nome:y=Y!"
    set "categoria_nome=!categoria_nome:z=Z!"
    
    echo [!opcao_num!] !categoria_nome!
    
    :: Armazenar mapeamento de opções
    set "opcoes_!opcao_num!=%%f"
    set "nomes_!opcao_num!=!categoria_nome!"
    
    set /a opcao_num+=1
)

set /a ultima_opcao=!opcao_num!-1
set /a opcao_todas=!opcao_num!
echo [!opcao_todas!] INSTALAR TODAS AS CATEGORIAS
echo.
echo [Q] Sair
echo.

set /p opcao=Digite sua opcao (1-!opcao_todas! ou Q): 

:: Verificar se é sair
if /i "%opcao%"=="Q" goto fim

:: Verificar se é instalar todas
if "%opcao%"=="!opcao_todas!" goto todas

:: Verificar opções de categoria
set "categoria_encontrada=0"
for /l %%i in (1,1,!ultima_opcao!) do (
    if "%opcao%"=="%%i" (
        set "categoria_encontrada=1"
        set "arquivo_categoria=!opcoes_%%i!"
        set "nome_categoria=!nomes_%%i!"
        goto executar_categoria
    )
)

if !categoria_encontrada! equ 0 (
    echo.
    echo Opcao invalida! Pressione qualquer tecla para continuar...
    pause >nul
    goto menu
)

:executar_categoria
set /a instalados=0
set /a ja_instalados=0
set /a erros=0

echo.
echo Instalando !nome_categoria!...
echo.

for /f "usebackq delims=" %%i in ("!arquivo_categoria!") do (
    call :install_app "%%i"
)

goto resultado

REM ============================
REM   TODAS AS CATEGORIAS
REM ============================
:todas
set /a total_apps=0
set /a instalados=0
set /a ja_instalados=0
set /a erros=0
set "nome_categoria=Todas as Categorias"

:: Contar total de aplicativos
for %%f in ("%categoria_dir%\*%extensao%") do (
    for /f "usebackq delims=" %%i in ("%%f") do set /a total_apps+=1
)

echo.
echo Voce esta prestes a instalar !total_apps! aplicativos.
echo Isso pode demorar bastante tempo.
echo.
set /p confirmar=Tem certeza que deseja continuar? (S/N): 

if /i not "!confirmar!"=="S" (
    echo.
    echo Instalacao cancelada.
    echo Pressione qualquer tecla para voltar ao menu...
    pause >nul
    goto menu
)

echo.
echo Instalando !nome_categoria!...
echo.

:: Instalar de todos os arquivos
for %%f in ("%categoria_dir%\*%extensao%") do (
    set "arquivo=%%~nf"
    
    :: Converter nome do arquivo para maiúsculas
    set "categoria_nome=!arquivo!"
    set "categoria_nome=!categoria_nome:a=A!"
    set "categoria_nome=!categoria_nome:b=B!"
    set "categoria_nome=!categoria_nome:c=C!"
    set "categoria_nome=!categoria_nome:d=D!"
    set "categoria_nome=!categoria_nome:e=E!"
    set "categoria_nome=!categoria_nome:f=F!"
    set "categoria_nome=!categoria_nome:g=G!"
    set "categoria_nome=!categoria_nome:h=H!"
    set "categoria_nome=!categoria_nome:i=I!"
    set "categoria_nome=!categoria_nome:j=J!"
    set "categoria_nome=!categoria_nome:k=K!"
    set "categoria_nome=!categoria_nome:l=L!"
    set "categoria_nome=!categoria_nome:m=M!"
    set "categoria_nome=!categoria_nome:n=N!"
    set "categoria_nome=!categoria_nome:o=O!"
    set "categoria_nome=!categoria_nome:p=P!"
    set "categoria_nome=!categoria_nome:q=Q!"
    set "categoria_nome=!categoria_nome:r=R!"
    set "categoria_nome=!categoria_nome:s=S!"
    set "categoria_nome=!categoria_nome:t=T!"
    set "categoria_nome=!categoria_nome:u=U!"
    set "categoria_nome=!categoria_nome:v=V!"
    set "categoria_nome=!categoria_nome:w=W!"
    set "categoria_nome=!categoria_nome:x=X!"
    set "categoria_nome=!categoria_nome:y=Y!"
    set "categoria_nome=!categoria_nome:z=Z!"
    
    echo [!categoria_nome!]
    for /f "usebackq delims=" %%i in ("%%f") do (
        call :install_app "%%i"
    )
    echo.
)

goto resultado

REM ============================
REM   FUNCAO DE INSTALACAO
REM ============================
:install_app
echo Instalando: %~1
winget install -e --id %~1 -h >nul 2>&1

if !errorlevel! equ 0 (
    echo [SUCESSO] %~1 instalado
    set /a instalados+=1
) else if !errorlevel! equ -1978335189 (
    echo [JA INSTALADO] %~1
    set /a ja_instalados+=1
) else (
    echo [ERRO] Falha na instalacao de %~1
    set /a erros+=1
)
echo.
goto :eof

REM ============================
REM   RESULTADO E MENU
REM ============================
:resultado
echo.
echo =============================================
echo        RESULTADO DA INSTALACAO
echo =============================================
echo Categoria: !nome_categoria!
echo.
echo [+] Instalados com sucesso: %instalados%
echo [i] Ja instalados: %ja_instalados%
echo [-] Com erros: %erros%
echo.
echo =============================================
echo.
set /p continuar=Pressione ENTER para voltar ao menu ou Q para sair: 

if /i "%continuar%"=="Q" goto fim
goto menu

:fim
echo.
echo Aplicacao encerrada.
pause
exit /b 0