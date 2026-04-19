@echo off
title TF-777 OS - INICIALIZADOR
color 0b

:: 1. Limpa o cache para evitar que logs de versões antigas apareçam
if exist __pycache__ (
    rd /s /q __pycache__
)

echo ======================================================
echo           TF-777 OS - INICIALIZANDO NUCLEO
echo ======================================================
echo.

:: 2. Executa o Python chamando o main.py
:: Se o seu arquivo final for main_o.py, altere o nome abaixo:
"%AppData%\.tf777_files\python\python.exe" main.py

echo.
echo ======================================================
echo    SISTEMA ENCERRADO OU FINALIZADO COM ERRO
echo ======================================================
pause
