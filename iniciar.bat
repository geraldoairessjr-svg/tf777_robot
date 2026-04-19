@echo off
cd /d "%~dp0"
setlocal

echo =========================
echo Baixando FFMPEG.zip...
echo =========================

REM Caminho da pasta onde o .bat está
set "PASTA=%~dp0"

REM URL do arquivo
set "URL=https://github.com/geraldoairessjr-svg/tf777_robot/releases/download/ZIP/FFMPEG.zip"

REM Nome do arquivo de saída
set "ARQUIVO=%PASTA%FFMPEG.zip"

REM Download usando PowerShell
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ARQUIVO%'"

if exist "%ARQUIVO%" (
echo Download concluido com sucesso!
) else (
echo ERRO ao baixar o arquivo.
)
tar -xf "FFMPEG.zip"
echo Iniciando...
python main.py
pause
