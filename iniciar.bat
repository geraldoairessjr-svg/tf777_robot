@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

REM Vai para AppData da TF777
cd /d "%APPDATA%\.tf777_files"

REM Executa o main.py com Python
python main.py

REM Se fechar sem erro, pausa para mostrar mensagem
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
