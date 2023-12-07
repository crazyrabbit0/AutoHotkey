#NoTrayIcon
#SingleInstance Ignore

; Exclude from Windows Defender & Wait 1 Second
RunWait '*RunAs "powershell.exe" "Add-MpPreference -ExclusionPath `'' . A_Temp . '`'"', , 'Hide'
Sleep 500

; Copy & Run temp patch
temp_file := A_Temp . '\' . A_ScriptName
temp_file := RegExReplace(temp_file, 'i)\.ahk$', '.exe')
FileInstall 'patch.exe', temp_file, 1
Run '"' . temp_file . '" /startupworkdir "' . A_WorkingDir . '"', , , &temp_process_pid

; Wait for temp patch to open & rename associated dll
WinWait 'ahk_pid ' . temp_process_pid
FileMove A_Temp . '\dup2patcher.dll', temp_file . '.dll'

; Wait for temp patch to close & delete temp patch + associated dll
WinWaitClose 'ahk_pid ' . temp_process_pid
FileDelete temp_file 
FileDelete temp_file . '.dll'

; Remove Windows Defender Exclusion
RunWait '*RunAs "powershell.exe" "Remove-MpPreference -ExclusionPath `'' . A_Temp . '`'"', , 'Hide'