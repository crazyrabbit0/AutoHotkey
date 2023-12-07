#NoTrayIcon
#SingleInstance Ignore

downloads	:= A_Desktop . '\..\Downloads\'
ahk2exe		:= A_AhkPath . '\..\Ahk2Exe.exe'
temp_patch	:= 'patch.exe'
script		:= 'Patch Runner.ahk'
icon		:= '.icons\CrazyRabbit  (48x48).ico'

if A_Args.Length >= 1 {
	original_patch := A_Args[1]
}
else {
	Loop Files downloads . '\*-patch.exe', 'R'
		original_patch := A_LoopFileFullPath
}
SplitPath original_patch, &patch_name
final_patch := downloads . '\' . patch_name

FileMove original_patch, temp_patch, 1

; Compile patch runner
RunWait '"' . ahk2exe . '" /in "' . script . '" /out "' . final_patch . '" /icon "' . icon . '" /compress 2', , 'Hide'

; Delete temp patch
FileDelete temp_patch