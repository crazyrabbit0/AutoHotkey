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