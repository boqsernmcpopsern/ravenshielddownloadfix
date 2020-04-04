# NEMO's o store Ravenshield script
#$ravenshieldmappa = (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\WOW6432Node\Red Storm Entertainment\RAVENSHIELD" -Name "InstalledPath").InstalledPath
$ravenshieldmappa = "F:\Rainbow Six 3 Gold"
# mappack download
# NEMO's lille Ravenshield script
$ravenshieldmappa = (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\WOW6432Node\Red Storm Entertainment\RAVENSHIELD" -Name "InstalledPath").InstalledPath

$path = $ravenshieldmappa + "\maps\DisgruntledCustomers2012.rsm"
if (!(Test-Path $path)) {
    $start = get-date
    $ravenshieldmappack = "http://killingnemo.org/NEMO/Nemo_pack.zip"
    $rvsmappack = New-Item -Path $env:TEMP -Name "ravenshieldmappack" -ItemType "directory"
    Start-BitsTransfer -Source $ravenshieldmappack -Destination $rvsmappack.FullName
    $zipfile = $rvsmappack.FullName + "\Nemo_pack.zip"
    # extract but do not replace existing files
    Expand-Archive -LiteralPath $zipfile -DestinationPath $ravenshieldmappa -ErrorAction SilentlyContinue
    $end = get-date
    Write-Output "Time taken: $(($end).Subtract($start).Seconds) second(s)"
}

#$ravenshieldini = "C:\Program Files (x86)\Steam\steamapps\common\Rainbow Six 3 Gold\system\RavenShield.ini"

$ravenshieldini = $ravenshieldmappa + "\system\RavenShield.ini"
(Get-Content $ravenshieldini) | ForEach-Object { $_ -replace 'ConfiguredInternetSpeed=.*', 'ConfiguredInternetSpeed=2000000' } | Set-Content $ravenshieldini
(Get-Content $ravenshieldini) | ForEach-Object { $_ -replace 'ConfiguredLanSpeed=.*', 'ConfiguredLanSpeed=2000000' } | Set-Content $ravenshieldini

# endre binds?
# shift for walk
# right mouse for zoom
# r for reload
# C:\Program Files (x86)\Steam\steamapps\common\Rainbow Six 3 Gold\Save\Profiles\user.ini

# starte ravenshield
# ravenshield.exe -norunaway
