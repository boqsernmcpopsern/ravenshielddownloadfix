$unnskyldninger = @("Et glass kan da ikke skade!"
"Fastlegen min anbefalte meg å ta noen øl akkurat i dag"
"Den er feilmerket, den er egentlig alkoholfri!"
"Det er den internasjonale ta en øl for de fattige barna dagen")

function EnableAllVoices
{
# region installvoice
# Låse opp voices for bruk i alle kontekster:
$sourcePath = 'HKLM:\software\Microsoft\Speech_OneCore\Voices\Tokens' #Where the OneCore voices live
$destinationPath = 'HKLM:\SOFTWARE\Microsoft\Speech\Voices\Tokens' #For 64-bit apps
$destinationPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\SPEECH\Voices\Tokens' #For 32-bit apps
cd $destinationPath
$listVoices = Get-ChildItem $sourcePath
foreach($voice in $listVoices)
{
$source = $voice.PSPath #Get the path of this voices key
copy -Path $source -Destination $destinationPath -Recurse
copy -Path $source -Destination $destinationPath2 -Recurse
}
#endregion
}

Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.SelectVoice("Microsoft Jon") # setter norsk språk som standard. spytter trolig ut en feilmelding om du ikke har installert det.

<# # Liste opp alle installerte språk:
Foreach ($voice in $speak.GetInstalledVoices()){
    $Voice.VoiceInfo | Select-Object Gender, Name, Culture, Description
}
#>

function Get-Excuse 
{$words = Get-Random -InputObject $unnskyldninger
$speak.Speak($words)
}

Get-Excuse
