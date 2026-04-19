Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$appData = "$env:APPDATA\.tf777"
$url = "https://github.com/geraldoairessjr-svg/tf777_robot/archive/refs/heads/main.zip"

# Janela Principal Grande
$form = New-Object System.Windows.Forms.Form
$form.Text = "TF777 ROBOT FRAMEWORK - SETUP WIZARD V2.0"
$form.Size = New-Object System.Drawing.Size(600, 550)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(25, 25, 25)
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false

# Fontes
$fontTitulo = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fontTexto = New-Object System.Drawing.Font("Segoe UI", 10)
$fontLog = New-Object System.Drawing.Font("Consolas", 9)

# --- PAINEIS (TELAS) ---

# TELA 1: TERMOS
$pnl1 = New-Object System.Windows.Forms.Panel
$pnl1.Size = $form.ClientSize
$form.Controls.Add($pnl1)

$lblT1 = New-Object System.Windows.Forms.Label
$lblT1.Text = "BEM-VINDO AO TF777 ROBOT"
$lblT1.Font = $fontTitulo
$lblT1.ForeColor = [System.Drawing.Color]::Cyan
$lblT1.Location = "20,20"
$lblT1.AutoSize = $true
$pnl1.Controls.Add($lblT1)

$txtTermos = New-Object System.Windows.Forms.TextBox
$txtTermos.Multiline = $true
$txtTermos.ReadOnly = $true
$txtTermos.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$txtTermos.ForeColor = [System.Drawing.Color]::White
$txtTermos.Text = "TERMOS E CONDICOES:`r`n`r`n1. Este software instalara componentes em AppData\.tf777`r`n2. Serao instalados: Python 3, FFmpeg e Node.js via Winget.`r`n3. Todos os seus dados na pasta antiga .tf777 serao deletados em caso de update.`r`n4. Voce precisa de conexao com a internet.`r`n`r`nAo clicar em 'Aceitar', voce concorda com a instalacao automatica de todas as bibliotecas solicitadas."
$txtTermos.Location = "20,70"
$txtTermos.Size = "540,250"
$pnl1.Controls.Add($txtTermos)

$chkAceito = New-Object System.Windows.Forms.CheckBox
$chkAceito.Text = "Eu aceito os termos acima"
$chkAceito.ForeColor = [System.Drawing.Color]::White
$chkAceito.Location = "20,330"
$chkAceito.AutoSize = $true
$pnl1.Controls.Add($chkAceito)

$btnNext1 = New-Object System.Windows.Forms.Button
$btnNext1.Text = "PROXIMO >"
$btnNext1.Location = "430,450"
$btnNext1.Size = "130,40"
$btnNext1.Enabled = $false
$btnNext1.FlatStyle = "Flat"
$btnNext1.ForeColor = [System.Drawing.Color]::White
$btnNext1.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$pnl1.Controls.Add($btnNext1)

# TELA 2: DETALHES TECNICOS
$pnl2 = New-Object System.Windows.Forms.Panel
$pnl2.Size = $form.ClientSize
$pnl2.Visible = $false
$form.Controls.Add($pnl2)

$lblT2 = New-Object System.Windows.Forms.Label
$lblT2.Text = "DETALHES DA CONFIGURACAO"
$lblT2.Font = $fontTitulo
$lblT2.ForeColor = [System.Drawing.Color]::Cyan
$lblT2.Location = "20,20"
$lblT2.AutoSize = $true
$pnl2.Controls.Add($lblT2)

$lblInfo = New-Object System.Windows.Forms.Label
$lblInfo.Text = "O instalador verificara e instalara silenciosamente:`n`n- PYTHON 3.11 (Base do Robo)`n- FFMPEG (Processamento de Audio/Video)`n- NODE.JS (Suporte a Scripts)`n- BIBLIOTECAS: CustomTkinter, OpenCV, PyGame e mais.`n`nLocal: $appData"
$lblInfo.ForeColor = [System.Drawing.Color]::White
$lblInfo.Font = $fontTexto
$lblInfo.Location = "25,80"
$lblInfo.Size = "500,200"
$pnl2.Controls.Add($lblInfo)

$btnNext2 = New-Object System.Windows.Forms.Button
$btnNext2.Text = "INICIAR AGORA"
$btnNext2.Location = "430,450"
$btnNext2.Size = "130,40"
$btnNext2.FlatStyle = "Flat"
$btnNext2.ForeColor = [System.Drawing.Color]::White
$btnNext2.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$pnl2.Controls.Add($btnNext2)

# TELA 3: INSTALACAO (LOG E BARRA)
$pnl3 = New-Object System.Windows.Forms.Panel
$pnl3.Size = $form.ClientSize
$pnl3.Visible = $false
$form.Controls.Add($pnl3)

$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.Location = "20,20"
$logBox.Size = "540,300"
$logBox.BackColor = "Black"
$logBox.ForeColor = "Lime"
$logBox.Font = $fontLog
$logBox.ReadOnly = $true
$pnl3.Controls.Add($logBox)

$progBar = New-Object System.Windows.Forms.ProgressBar
$progBar.Location = "20,340"
$progBar.Size = "540,30"
$pnl3.Controls.Add($progBar)

$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Text = "Aguardando..."
$lblStatus.ForeColor = "Yellow"
$lblStatus.Location = "20,380"
$lblStatus.AutoSize = $true
$pnl3.Controls.Add($lblStatus)

# --- LOGICA DOS BOTOES ---

$chkAceito.Add_CheckedChanged({
    $btnNext1.Enabled = $chkAceito.Checked
    if($btnNext1.Enabled){ $btnNext1.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215) }
    else { $btnNext1.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60) }
})

$btnNext1.Add_Click({ $pnl1.Visible = $false; $pnl2.Visible = $true })

$btnNext2.Add_Click({
    $pnl2.Visible = $false
    $pnl3.Visible = $true
    Executar-Instalacao
})

function Write-Log($m) {
    $t = Get-Date -Format "HH:mm:ss"
    $logBox.AppendText("[$t] $m`n")
    $logBox.ScrollToCaret()
    $form.Refresh()
}

function Executar-Instalacao {
    Write-Log "INICIANDO PROTOCOLO DE INSTALACAO..."
    $progBar.Value = 5

    # Check Diretorio e cria se nao existir
    if (Test-Path $appData) {
        Write-Log "AVISO: Pasta antiga encontrada em AppData."
        Write-Log "Limpando arquivos anteriores para Update..."
        Remove-Item $appData -Recurse -Force
    }

    # CRIAR A PASTA .tf777 EXPLICITAMENTE
    Write-Log "Criando pasta: $appData"
    New-Item -ItemType Directory -Path $appData -Force | Out-Null
    if (-not (Test-Path $appData)) {
        Write-Log "ERRO CRITICO: Nao conseguiu criar pasta $appData"
        [System.Windows.Forms.MessageBox]::Show("Erro ao criar pasta AppData!", "Erro")
        return
    }

    # Winget Apps com Correcao de Aceite Automatico
    $apps = @("OpenJS.NodeJS", "Gyan.FFmpeg", "Python.Python.3.11")
    $val = 10
    foreach($a in $apps){
        Write-Log "Verificando componente: $a"
        $lblStatus.Text = "Instalando $a..."
        $form.Refresh()
        # Adicionado --accept-source-agreements para evitar a trava do 'Y'
        Start-Process winget -ArgumentList "install -e --id $a --silent --accept-package-agreements --accept-source-agreements" -Wait -NoNewWindow
        $val += 15
        $progBar.Value = $val
    }

    # Download
    Write-Log "Baixando Master-Zip do GitHub..."
    $lblStatus.Text = "Baixando arquivos principais..."
    $tmp = "$env:TEMP\tf.zip"
    Invoke-WebRequest -Uri $url -OutFile $tmp

    Write-Log "Extraindo repositorio..."
    $progBar.Value = 70
    Expand-Archive -Path $tmp -DestinationPath "$env:TEMP\tf_ext" -Force
    $sub = Get-ChildItem "$env:TEMP\tf_ext" | Select-Object -First 1

    # Copia com mais debug
    Write-Log "Copiando arquivos para $appData..."
    Copy-Item -Path "$($sub.FullName)\*" -Destination $appData -Recurse -Force

    # Verifica se funcionou
    if (-not (Test-Path "$appData\main.py")) {
        Write-Log "AVISO: main.py nao encontrado apos copia!"
        Write-Log "Tentando copiar via Move-Item..."
        Move-Item -Path "$($sub.FullName)\*" -Destination $appData -Force -ErrorAction Continue
    }

    Write-Log "Arquivos movidos para AppData\.tf777 com sucesso."

    # Force timestamp para garantir arquivo novo
    Write-Log "Atualizando timestamps dos arquivos..."
    Get-ChildItem $appData -File -Recurse | ForEach-Object { $_.LastWriteTime = Get-Date }
    Write-Log "Timestamps atualizados."

    # PIP
    Write-Log "Instalando bibliotecas Python (PIP)..."
    $lblStatus.Text = "Configurando ambiente Python (Demorado)..."
    $libs = "customtkinter google-genai pygame gTTS SpeechRecognition yt-dlp pyserial opencv-python"
    Start-Process python -ArgumentList "-m pip install --upgrade pip" -Wait -NoNewWindow
    Start-Process python -ArgumentList "-m pip install $libs" -Wait -NoNewWindow

    # Atalho (SO AGORA QUE A PASTA EXISTE)
    Write-Log "Criando atalho na Area de Trabalho..."
    if (Test-Path "$appData\iniciar.exe") {
        $s = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:USERPROFILE\Desktop\TF777_Robot.lnk")
        $s.TargetPath = "$appData\iniciar.exe"
        $s.WorkingDirectory = $appData
        $s.Save()
        Write-Log "Atalho criado com sucesso!"
    } else {
        Write-Log "AVISO: iniciar.exe nao encontrado em $appData"
    }

    $progBar.Value = 100
    $lblStatus.Text = "INSTALACAO CONCLUIDA!"
    Write-Log "SUCESSO: O sistema esta pronto para uso."
    [System.Windows.Forms.MessageBox]::Show("Instalacao Concluida!", "TF777 Setup")
    $form.Close()
}

[void]$form.ShowDialog()