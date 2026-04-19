@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo ===============================
echo Instalador + Runner TF777
echo ===============================

REM ===============================
REM 1. Instalar FFmpeg (se nao existir)
REM ===============================
if exist ffmpeg.exe (
    echo FFmpeg ja encontrado na pasta.
) else (
    echo Baixando FFmpeg...

    set URL=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip
    set ZIP=ffmpeg.zip

    powershell -Command "Invoke-WebRequest -Uri %URL% -OutFile %ZIP%"

    if not exist %ZIP% (
        echo Erro ao baixar o FFmpeg.
        pause
        exit /b
    )

    echo Extraindo FFmpeg...
    powershell -Command "Expand-Archive -Path %ZIP% -DestinationPath . -Force"

    for /d %%i in (ffmpeg-*) do (
        set FOLDER=%%i
    )

    echo Movendo executaveis...
    xcopy "%FOLDER%\bin\*" "." /E /I /Y > nul

    rmdir /s /q "%FOLDER%"
    del %ZIP%

    echo FFmpeg instalado com sucesso!
)

REM ===============================
REM 2. Rodar TF777
REM ===============================

echo.
echo Iniciando TF777...

cd /d "%APPDATA%\.tf777_files"

python main.py

REM ===============================
REM 3. Verificacao de erro
REM ===============================

if %errorlevel% equ 0 (
    echo.
    echo TF777 finalizou com sucesso.
    pause
) else (
    echo.
    echo ERRO ao executar TF777!
    echo Codigo de erro: %errorlevel%
    pause
)
