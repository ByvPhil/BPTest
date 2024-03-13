if (-not (test-path -path "$Env:temp\speedtest.exe")) 
{
write-host "non present"
$sWebRequest = @{
    Uri = 'https://github.com/TECHCSID/BPtest/raw/main/speedtest.exe'
    OutFile = "$Env:temp\speedtest.exe"
}
Invoke-WebRequest @sWebRequest
}
$Speedtest = cmd /c "$Env:temp\speedtest.exe -f json --accept-gdpr --accept-license"
$Download = $Speedtest.split(':')[11]
$resultD = $Download.split(',')[0]
$Upload = $Speedtest.split(':')[20]
$resultU = $Upload.split(',')[0]
$ResultUtemp = ($resultD / 1000000)
$XDownload = $ResultUtemp * 8
$res1 = [math]::round($XDownload,2)

$ResultUtempB = ($resultU / 1000000)
$Xupload = $ResultUtempB * 8
$res2 = [math]::round($Xupload,2)

$PourRG = "Download: $res1 Mb/s ;Upload: $res2 Mb/s"

$array = $speedtest -split "isp"
$array2 = $array -split "interface"
$trim = $array2[1]
$words = $trim.Split(":")[1]
$resultISP = $words.split(',')[0]

$array3 = $Speedtest.split(':')[7]
$resultLA = $array3.split(',')[0]
$res3 = [math]::round($resultLA,2)

write-output "$PourRG ;Ping: $res3 ms ;ISP:$resultISP"
