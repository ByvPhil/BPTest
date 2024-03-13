if (-not (test-path -path "C:\Windows\Temp\rgsupv\speedtest.exe")) {

write-host "Speedtest non présent"

$url = "https://github.com/TECHCSID/BPtest/blob/main/speedtest.exe"
$output = "C:\Windows\Temp\rgsupv\speedtest.exe"
}

$Speedtest = cmd /c "C:\Windows\Temp\rgsupv\speedtest.exe -f json --accept-gdpr --accept-license"
$Download = $Speedtest.split(':')[9]
$resultD = $Download.split(',')[0]
$Upload = $Speedtest.split(':')[13]
$resultU = $Upload.split(',')[0]
$ResultUtemp = ($resultD / 1000000)
$XDownload = $ResultUtemp * 8
$res1 = [math]::round($XDownload,2)

$ResultUtempB = ($resultU / 1000000)
$Xupload = $ResultUtempB * 8
$res2 = [math]::round($Xupload,2)

$PourRG = "Download: $res1 Mb/s Upload: $res2 Mb/s"

$array = $speedtest -split "isp"
$array2 = $array -split "interface"
$trim = $array2[1]
$words = $trim.Split(":")[1]
$resultISP = $words.split(',')[0]

$array3 = $speedtest -split "latency"
$trim2 = $array3[1]
$words2 = $trim2.Split(":")[1]
$resultLA = $words2.split('}')[0]
$res3 = [math]::round($resultLA,2)

$registryPath = "HKLM:\Software\SECIB\DebitInternet"
$registryPath2 = "HKLM:\Software\SECIB"

If (-not (Test-Path $registryPath2)) {New-Item -Path HKLM:\Software -Name SECIB –Force}
If (-not (Test-Path $registryPath)) {New-Item -Path HKlm:\Software\SECIB -Name DebitInternet –Force}

New-ItemProperty -Path $registryPath -Name 'Débit' -Value $PourRG -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $registryPath -Name 'FAI' -Value $resultISP -PropertyType STRING -Force | Out-Null
write-output "$PourRG Ping: $res3 ms Provider:$resultISP"
