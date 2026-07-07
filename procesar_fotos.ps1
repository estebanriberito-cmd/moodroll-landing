# MOODROLL - Procesar fotos locales para la web
# Corre esto en PowerShell (dentro de VS Code o la terminal de Windows normal)

Add-Type -AssemblyName System.Drawing

function Process-Folder {
    param($SourceFolder, $DestFolder)

    New-Item -ItemType Directory -Force -Path $DestFolder | Out-Null

    $files = Get-ChildItem -Path $SourceFolder -File |
        Where-Object { $_.Extension -match '(?i)^\.(jpg|jpeg|png)$' } |
        Sort-Object Name

    $jpgCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
        Where-Object { $_.MimeType -eq 'image/jpeg' }

    $i = 1
    foreach ($file in $files) {
        $img = [System.Drawing.Image]::FromFile($file.FullName)

        # Recorte cuadrado centrado
        $size = [Math]::Min($img.Width, $img.Height)
        $x = [int](($img.Width - $size) / 2)
        $y = [int](($img.Height - $size) / 2)
        $cropRect = New-Object System.Drawing.Rectangle($x, $y, $size, $size)

        $cropped = New-Object System.Drawing.Bitmap($size, $size)
        $g1 = [System.Drawing.Graphics]::FromImage($cropped)
        $g1.DrawImage($img, (New-Object System.Drawing.Rectangle(0,0,$size,$size)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)

        # Redimensionar a 600x600 (liviano para web)
        $final = New-Object System.Drawing.Bitmap(600, 600)
        $g2 = [System.Drawing.Graphics]::FromImage($final)
        $g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g2.DrawImage($cropped, 0, 0, 600, 600)

        $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
            [System.Drawing.Imaging.Encoder]::Quality, [int64]85)

        $outPath = Join-Path $DestFolder "$i.jpg"
        $final.Save($outPath, $jpgCodec, $encParams)

        $g1.Dispose(); $g2.Dispose(); $cropped.Dispose(); $final.Dispose(); $img.Dispose()
        Write-Host "  Guardado: $outPath"
        $i++
    }
    return $i - 1
}

# ---- RUTAS: ya ajustadas a lo que me pasaste ----
$ProjectRoot = "C:\Users\Esteban\Desktop\moodroll-landing"

Write-Host "Procesando FLASHBACK 2003..."
$countFlash = Process-Folder `
    -SourceFolder "C:\Users\Esteban\Desktop\MoodRoll\Flashbak 2003" `
    -DestFolder "$ProjectRoot\assets\gallery\flashback"

Write-Host "Procesando FOOD GLOW..."
$countFood = Process-Folder `
    -SourceFolder "C:\Users\Esteban\Desktop\MoodRoll\Food glow" `
    -DestFolder "$ProjectRoot\assets\gallery\foodglow"

# Copia la primera foto de cada carpeta como swatch de la tarjeta del Starter Pack
New-Item -ItemType Directory -Force -Path "$ProjectRoot\assets\swatches" | Out-Null
Copy-Item "$ProjectRoot\assets\gallery\flashback\1.jpg" "$ProjectRoot\assets\swatches\flashback_2003.jpg" -Force
Copy-Item "$ProjectRoot\assets\gallery\foodglow\1.jpg" "$ProjectRoot\assets\swatches\food_glow.jpg" -Force

Write-Host ""
Write-Host "LISTO."
Write-Host "FLASHBACK 2003: $countFlash fotos procesadas"
Write-Host "FOOD GLOW: $countFood fotos procesadas"
Write-Host "Ya estan copiadas dentro de assets/gallery/ y assets/swatches/ del proyecto."
