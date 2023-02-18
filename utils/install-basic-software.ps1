#   Description:
# This script will use Windows package manager to bootstrap Chocolatey and
# install a list of packages. Script will also install Sysinternals Utilities
# into your default drive's root directory.
$PSDefaultParameterValues = @{}
$PSDefaultParameterValues += @{'*:ErrorAction' = 'SilentlyContinue'} #Errors that don't interfere with normal operation are common in this script.
$packages = @(  
    "tinywall"
    "w10privacy"
    "parsec"
    "ublockorigin-chrome"
    "shutup10"
    "powerGUI"
    "shotcut"
    "discord"
    "obs-studio.install"
    "cpu-z.install"
    "rufus"
    "greenshot"
    "psping"
    "calibre"
    "crystaldiskinfo"
    "autohotkey.install"
    "irfranview"
    "everything"
    "powertoys"
    "libreoffice-fresh"
    "nvidia-display-driver"
    "k-litecodecpackfull"
    "winlogbeat" #network analyzer
    "putty.install" #SSH client
    "foxitreader" #Free PDF reader
    "dotnetfx"
    "chocolatey-core.extension" #unsure if this does anything
    "steam.install"
    "notepadplusplus.install"
    #"peazip.install"
    "7zip.install"
    #"aimp"
    #"audacity"
    #"autoit"
    "classic-shell"
    "filezilla"
    "firefoxsr"
    #"gimp"
    "muilvad-app" #good VPN
    "google-chrome-x64"
    #"imgburn"
    #"keepass.install"
    "paint.net"
    #"putty"
    "python"
    "qbittorrent"
    #"speedcrunch"
    #"sysinternals"
    #"thunderbird"
    #"vlc"
    "windirstat"
    #"wireshark"
)

echo "Setting up Chocolatey software package manager"
Get-PackageProvider -Name chocolatey -Force

echo "Setting up Full Chocolatey Install"
Install-Package -Name Chocolatey -Force -ProviderName chocolatey
$chocopath = (Get-Package chocolatey | ?{$_.Name -eq "chocolatey"} | Select @{N="Source";E={((($a=($_.Source -split "\\"))[0..($a.length - 2)]) -join "\"),"Tools\chocolateyInstall" -join "\"}} | Select -ExpandProperty Source)
& $chocopath "upgrade all -y"
choco install chocolatey-core.extension --force

echo "Creating daily task to automatically upgrade Chocolatey packages"
# adapted from https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/23/using-scheduled-tasks-and-scheduled-jobs-in-powershell/
$ScheduledJob = @{
    Name = "Chocolatey Daily Upgrade"
    ScriptBlock = {choco upgrade all -y}
    Trigger = New-JobTrigger -Daily -at 7am
    ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
}
Register-ScheduledJob @ScheduledJob

echo "Installing Packages"
$packages | %{choco install $_ --force -y}

echo "Installing Sysinternals Utilities to C:\Sysinternals"
$download_uri = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$wc = new-object net.webclient
$wc.DownloadFile($download_uri, "/SysinternalsSuite.zip")
Add-Type -AssemblyName "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory("/SysinternalsSuite.zip", "/Sysinternals")
echo "Removing zipfile"
rm "/SysinternalsSuite.zip"
