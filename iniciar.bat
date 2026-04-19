@echo off
cd /d "%~dp0"
tar -xf "FFMPEG.zip"
echo Iniciando...
python main.py
pause
