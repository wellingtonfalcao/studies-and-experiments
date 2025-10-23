@echo off
setlocal enabledelayedexpansion

:: Obtém o diretório onde o script está localizado
set "input_dir=%~dp0"
:: Remove a barra final se existir
if "%input_dir:~-1%"=="\" set "input_dir=%input_dir:~0,-1%"

echo Processando arquivos em: %input_dir%
echo.

:: Verifica cada arquivo .mp4 no diretório
for %%F in ("%input_dir%\*.mp4") do (
    :: Obtém o nome do arquivo sem extensão
    for %%i in ("%%~nF") do (
        set nome_sem_extensao=%%~ni
        
        :: Define o caminho de saída (pasta com o nome do arquivo)
        set output_dir=%input_dir%\!nome_sem_extensao!
        
        :: Cria a pasta de saída se não existir
        if not exist "!output_dir!" (
            mkdir "!output_dir!"
        )
        
        :: Executa o Whisper para o arquivo atual
        echo Processando: %%~nxF
        whisper "%%F" ^
            --model medium ^
            --device cuda ^
            --task translate ^
            --language pt ^
            --output_dir "!output_dir!"
        
        echo Transcrição concluída para %%~nxF! Os arquivos foram salvos em: !output_dir!
        echo.
    )
)

echo Todos os arquivos .mp4 foram processados!
pause