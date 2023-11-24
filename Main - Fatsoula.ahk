	
;############################## Variables ##############################
	
	#SingleInstance Force
	
	debugging := 0
	use_custom_volume := 1
	
;############################## Includes ##############################
	
	#Include "Multimedia.ahk"
	#Include "Mouse Volume.ahk"
	
;############################## Hotkeys ##############################

#HotIf
	
	/::/
	
	>^/::Reload
	
	>!/::Pause -1
	
	#SuspendExempt True
	>^>!/::Suspend
	#SuspendExempt False
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Notepad++ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#HotIf WinActive(".ahk - Notepad ahk_exe notepad++.exe") or WinActive(".ahk - Notepad ahk_exe notepad.exe")
	
	~^s::Reload
	