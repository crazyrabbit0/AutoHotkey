#Include System\ScriptGuard1.ahk    ; Can adjust for location of ScriptGuard1.ahk
;@Ahk2Exe-Obey U_Bin,= "%A_BasePath~^.+\.%" = "bin" ? "Cont" : "Nop" ; .bin?
;@Ahk2Exe-Obey U_au, = "%A_IsUnicode%" ? 2 : 1 ; Base file ANSI or Unicode?
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-%U_Bin%  "1%U_au%2.>AUTOHOTKEY SCRIPT<. RANDOM"
;@Ahk2Exe-Cont  "%U_au%.AutoHotkeyGUI.RANDOM"
; ;@Ahk2Exe-Cont  /ScriptGuard2  ; or /ScriptGuard2pss if required
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%" "11.UPX." "1.UPX!.", 2
;@Ahk2Exe-UpdateManifest 0 ,.

#NoTrayIcon
#SingleInstance Ignore

; Check for arguments
if A_Args.Length != 1 {
	MsgBox 'You should provide a patch as an argument for the program!', "Patch Packer:  Warning!", "Icon!"
	exit 1
}

; Variables
exclude_dir	:= A_Temp
temp_dir	:= A_Temp . '\patch_packer_' . A_ScriptHwnd
AutoHotkey	:= temp_dir . '\AutoHotkey64.exe'
script		:= temp_dir . '\Patch Runner.ahk'
Icon		:= temp_dir . '\Icon.ico'
Ahk2Exe		:= temp_dir . '\Ahk2Exe.exe'
Mpress		:= temp_dir . '\Mpress.exe'
BinMod		:= temp_dir . '\BinMod.exe'
ScriptGuard	:= temp_dir . '\ScriptGuard1.ahk'
original_patch	:= A_Args[1]
temp_patch	:= temp_dir . '\patch.exe'

; Create temp folder
DirCreate temp_dir

; Exclude temp folder from Windows Defender & Wait till exclusion is registered
RunWait '*RunAs "powershell.exe" "Add-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'
Loop {
	exclusion_exists := not(RunWait('*RunAs "powershell.exe" "(Get-MpPreference  | Select-Object -ExpandProperty ExclusionPath | Where-Object {$_ -eq `'' . exclude_dir . '`'})[0]"', , 'Hide'))
} Until exclusion_exists

; Move files to temp folder
FileInstall '..\..\AutoHotkey64.exe', AutoHotkey, true
FileInstall 'Patch Runner.ahk', script, true
FileInstall '.Icon.ico', Icon, true
FileInstall '..\..\Ahk2Exe\Ahk2Exe.exe', Ahk2Exe, true
FileInstall '..\..\Ahk2Exe\Mpress.exe', Mpress, true
FileInstall '..\..\Ahk2Exe\BinMod.exe', BinMod, true
FileInstall '..\System\ScriptGuard1.ahk', ScriptGuard, true
FileMove original_patch, temp_patch, true

; Compile patch runner
RunWait '"' . Ahk2Exe . '" /in "' . script . '" /out "' . original_patch . '" /base "' . AutoHotkey . '" /icon "' . Icon . '" /compress 1', , 'Hide'

; Delete temp folder
DirDelete temp_dir, true

; Remove Windows Defender exclusion
RunWait '*RunAs "powershell.exe" "Remove-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'

; Finish Message
MsgBox 'Patch packed successfully!', "Patch Packer:  Success!", "Iconi"