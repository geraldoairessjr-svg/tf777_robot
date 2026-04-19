#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SCRIPT PARA OFUSCAR main_o.py -> main.py
Use quando precisar proteger o código novamente
"""

import base64
import zlib
import marshal

def ofuscar_python(arquivo_entrada="main_o.py", arquivo_saida="main.py"):
    """
    Ofusca um arquivo Python usando marshal + zlib + base64
    """
    print(f"[*] Lendo {arquivo_entrada}...")
    with open(arquivo_entrada, 'r', encoding='utf-8') as f:
        codigo = f.read()

    print(f"[*] Compilando código...")
    codigo_compilado = compile(codigo, arquivo_entrada, 'exec')

    print(f"[*] Serializando com marshal...")
    codigo_serializado = marshal.dumps(codigo_compilado)

    print(f"[*] Comprimindo com zlib...")
    codigo_comprimido = zlib.compress(codigo_serializado, 9)  # Nível máximo

    print(f"[*] Codificando com base64...")
    codigo_encoded = base64.b64encode(codigo_comprimido)

    # Cria o arquivo ofuscado
    codigo_final = f"""import sys,marshal,zlib;exec(marshal.loads(zlib.decompress(__import__('base64').b64decode(b'{codigo_encoded.decode()}'))))"""

    print(f"[*] Salvando em {arquivo_saida}...")
    with open(arquivo_saida, 'w', encoding='utf-8') as f:
        f.write(codigo_final)

    tamanho_original = len(codigo)
    tamanho_ofuscado = len(codigo_final)
    reducao = ((tamanho_original - tamanho_ofuscado) / tamanho_original) * 100

    print()
    print("OK - SUCESSO!")
    print(f"================================================================")
    print(f"Original:  {tamanho_original:,} bytes")
    print(f"Ofuscado:  {tamanho_ofuscado:,} bytes")
    print(f"Reducao:   {reducao:.1f}%")
    print(f"================================================================")
    print()
    print("[*] Para testar:")
    print(f"    python {arquivo_saida}")

if __name__ == "__main__":
    try:
        ofuscar_python("main_o.py", "main.py")
        print("[OK] Arquivo ofuscado criado com sucesso!")
    except FileNotFoundError:
        print("[ERRO] Erro: arquivo 'main_o.py' nao encontrado!")
    except Exception as e:
        print(f"[ERRO] Erro: {e}")
