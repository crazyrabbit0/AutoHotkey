#NoTrayIcon
#SingleInstance Ignore

; Check for arguments
if A_Args.Length != 1 {
	MsgBox 'You should provide a patch as an argument for the program!', "Patch Packer:  Warning!", "Icon!"
	exit 1
}

; Variables
original_patch	:= A_Args[1]
exclude_dir	:= A_Temp . '\patch_packer_*'
temp_dir	:= A_Temp . '\patch_packer_' . A_ScriptHwnd
ahk2exe		:= temp_dir . '\Ahk2Exe.exe'
autohotkey32	:= temp_dir . '\AutoHotkey32.exe'
mpress		:= temp_dir . '\Mpress.exe'
script		:= temp_dir . '\Patch Runner.ahk'
icon		:= temp_dir . '\CrazyRabbit  (48x48).ico'
temp_patch	:= temp_dir . '\patch.exe'

; Create temp folder
DirCreate temp_dir

; Exclude temp folder from Windows Defender & Wait till exclusion is registered
RunWait '*RunAs "powershell.exe" "Add-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'
Loop {
	exclusion_exists := not(RunWait('*RunAs "powershell.exe" "(Get-MpPreference  | Select-Object -ExpandProperty ExclusionPath | Where-Object {$_ -eq `'' . exclude_dir . '`'})[0]"', , 'Hide'))
} Until exclusion_exists

; Move files to temp folder
FileInstall '..\Ahk2Exe.exe', ahk2exe, true
FileInstall '..\AutoHotkey32.exe', autohotkey32, true
FileInstall '..\Mpress.exe', mpress, true
FileInstall 'Patch Runner.ahk', script, true
FileInstall '.icons\CrazyRabbit  (48x48).ico', icon, true
FileMove original_patch, temp_patch, true

; Compile patch runner
RunWait '"' . ahk2exe . '" /in "' . script . '" /out "' . original_patch . '" /icon "' . icon . '" /compress 1', , 'Hide'

; Delete temp folder
DirDelete temp_dir, true

; Remove Windows Defender exclusion
RunWait '*RunAs "powershell.exe" "Remove-MpPreference -ExclusionPath `'' . exclude_dir . '`'"', , 'Hide'

; Finish Message
MsgBox 'Patch packed successfully!', "Patch Packer:  Success!", "Iconi"