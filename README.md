# Debloat Windows 10 Tournament Edition
#Notes from Silky preceded by #

**Note about Windows 11:**
This project does not directly support Windows 11.
Things might work, or might not work - find out if you are brave.
Do not expect this project to transition to Windows 11 as the maintainer lacks the time to do so.

This project collects PowerShell scripts which help to *debloat* Windows 10,
tweak common settings and install basic software components.

#This fork includes additional settings for Windows to speed up setup on a fresh machine, as well as (coming soon) automate settings changes to +R and Steam.

I test these scripts on a Windows 10 Professional 64-Bit (English) virtual
machine. Please let me know if you encounter any issues. Home Edition and
different languages are not supported. These scripts are intended for
tech-savvy administrators, who know what they are doing and just want to
automate this phase of their setup. If this profile does not fit you, I
recommend using a different (more interactive) tool -- and there are a lot of
them out there.

Also, note that gaming-related apps and services will be removed/disabled. If
you intend to use your system for gaming, adjust the scripts accordingly.
#I am unaware of any fighting games requiring a Microsoft sign-in through Steam versions. #wip comment xbox svc

**There is no undo**, I recommend only using these scripts on a fresh
installation (including Windows Updates). Test everything after running them
before doing anything else. Also, there is no guarantee that everything will
work after future updates since I cannot predict what Microsoft will do next.

## Translations

- [Fork with German version](https://github.com/MagicLike/Debloat-Windows-10/blob/master/README.de-de.md)



## Download Latest Version

Code located in the `master` branch is always considered under development, but
you'll probably want the most recent version anyway.

- [Download [zip]](https://github.com/W4RH4WK/Debloat-Windows-10/archive/master.zip)

## Execution

Enable execution of PowerShell scripts:

    PS> Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Unblock PowerShell scripts and modules within this directory:

    PS> ls -Recurse *.ps*1 | Unblock-File

# Usage

#Right now where it's at is that you should be able to use a fresh or ready PC with all of the scripts, run a few utils (lower-ram-usage.reg, prefetch-prelaunch.ps1, -disable-scheduled-tasks.ps1, and later on when I reconfigure it to download steam automatically, install-basic-software.ps1), then restart, run disable defender again, then reboot. It is a bit cumbersome to reboot a couple times, but some defender removal methods arent as permanent, and I'm gonna work on finding one that only requires one reboot if any. https://notepad.link/share/JrR4lCdlO6cYxSzyRCFd These scripts are meant to handle everything described on the Windows end in https://notepad.link/share/JrR4lCdlO6cYxSzyRCFd, however you will need to intall Steam, any necessary utilities, and do the setup for +R 

1. Install all available updates for your system.
2. Edit the scripts to fit your need.
3. Run the scripts you want to apply from a PowerShell with administrator privileges (Explorer
   `Files > Open Windows PowerShell > Open Windows PowerShell as
   administrator`)
   #3.5. Run lower-ram-usage.reg, disable-prefetch-prelaunch.ps1, disable-scheduled-tasks.ps1
4. `PS > Restart-Computer`
5. Run `disable-windows-defender.ps1` one more time if you ran it in step 3
6. `PS > Restart-Computer`
# After this, you will want to grab Steam, +R, and set up according to ttps://notepad.link/share/JrR4lCdlO6cYxSzyRCFd
Optionally, you can run lower-ram-usage, disable-prefetch-prelaunch, and disable-edge-prelaunch
## Start menu

In the past I included small fixes to make the start menu more usable, like
removing default tiles, disabling web search and so on. This is no longer the
case since I am fed up with it. This fucking menu breaks for apparently
no reason, is slow, is a pain to configure / script and even shows ads out of
the box!

Please replace it with something better, either use [Open Shell] or [Start
is Back], but stop using that shit.

[Open Shell]: <https://open-shell.github.io/Open-Shell-Menu/>
[Start is Back]: <http://startisback.com/>

## Known Issues

### Start menu Search

After running the scripts, the start menu search-box may no longer work on newly
created accounts. It seems like there is an issue with account initialization
that is triggered when disabling the GeoLocation service. Following workaround
has been discovered by BK from Atlanta:

1. Delete registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\TriggerInfo\3`
2. Re-enable GeoLocation service (set startup type to `Automatic`)
3. Reboot
4. Login with the account having the stated issue
5. Start Cortana and set your preferences accordingly (web search and whatnot)

You may now disable the GeoLocation service again, the search box should remain
functional.

### Sysprep will hang

If you are deploying images with MDT and running these scripts, the sysprep
step will hang unless `dmwappushservice` is active.

### Xbox Wireless Adapter

Apparently running the stock `remove-default-apps` script will cause Xbox
Wireless Adapters to stop functioning. I suspect one should not remove the Xbox
App when wanting to use one. But I haven't confirmed this yet, and there is a
workaround to re-enable it afterwards.
#Re-enable Xbox services by pressing Win+R, going to services.msc, and re-enabling Xbox stuff.
See
[#78](https://github.com/W4RH4WK/Debloat-Windows-10/issues/78).

### Issues with Skype

Some of the domains blocked by adding them to the hosts-file are required for
Skype. I highly discourage using Skype, however some people may not have
the option to use an alternative. See the
[#79](https://github.com/W4RH4WK/Debloat-Windows-10/issues/79).

### Fingerprint Reader / Facial Detection not Working

Ensure *Windows Biometric Service* is running. See
[#189](https://github.com/W4RH4WK/Debloat-Windows-10/issues/189).

## Liability

**All scripts are provided as-is and you use them at your own risk.**

## Contribute

I would be happy to extend the collection of scripts. Just open an issue or
send me a pull request.

### Thanks To

- [10se1ucgo](https://github.com/10se1ucgo)
- [Plumebit](https://github.com/Plumebit)
- [aramboi](https://github.com/aramboi)
- [maci0](https://github.com/maci0)
- [narutards](https://github.com/narutards)
- [tumpio](https://github.com/tumpio)
- 
-#Andy McRae @ Stackoverflow

-#Jelphy @ Stackoverflow

-#Shawn Brink @ tenforums


## License

    "THE BEER-WARE LICENSE" (Revision 42):

    As long as you retain this notice you can do whatever you want with this
    stuff. If we meet someday, and you think this stuff is worth it, you can
    buy us a beer in return.

    This project is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.
