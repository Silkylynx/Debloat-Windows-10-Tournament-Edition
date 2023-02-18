       reg add "HKLM\System\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f
        #disables windows push notifications
       New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar\" -Name "AllowAutoGameMode" -Force -Value "1" -PropertyType "DWORD"
       #I think this enables gamemode. #test for restart. 
       New-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0 -Force
       #Disables UAC. Test for restart.
        New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows" -Name "Explorer" -force
	New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -PropertyType "DWord" -Value 1 -Force 
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -PropertyType "DWord" -Value 0 -Force 
       #Unsure how to undo this one, also disables windows push notifications changing values was not immediately effective. Test for restart.
       #thanks to Andy McRae @ stackoverflow#>
       New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" -Name "DevicePasswordLessBuildVersion" -PropertyType "DWord" -Value 2 -Force
       #Forces Passwordless sign in, thanks to Shawn Brink at tenforums
       powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
	#high performance powerplan, thanks to Sven Eberth @ stack overflow
	powercfg -change -monitor-timeout-ac 0
	powercfg -change -standby-timeout-ac 0
	powercfg -change -hibernate-timeout-ac 0
	#neversleep thanks to Jelphy @ stackoverflow
	powercfg -change -monitor-timeout-dc 0
	powercfg -change -standby-timeout-dc 0
	powercfg -change -hibernate-timeout-dc 0
	#neversleepbatteryjustincase
       #changes monitor timeout to never

