	
;############################## Variables ##############################
	
	#SingleInstance Force
	
	debugging := 0
	use_custom_volume := 1
	
;############################## Includes ##############################
	
	#Include "Run as Administrator.ahk"
	#Include "Multimedia.ahk"
	#Include "Headphones.ahk"
	;#Include "Mouse Volume.ahk"
	
;############################## Hotkeys ##############################

#HotIf
	
	/::/
	
	>^/::Reload
	
	>!/::Pause -1
	
	#SuspendExempt True
	>^>!/::Suspend
	#SuspendExempt False
	
	>^Numpad0::
	{
		static toggle := 0
		toggle := !toggle
		
		if toggle
			SetTimer(press_ctrl_end_and_click, 2000)
		else
			SetTimer(press_ctrl_end_and_click, 0)

		press_ctrl_end_and_click()
		{
			Send "^{End}"
			Sleep 500
			Send "{LButton}"
		}
	}
	
#HotIf WinActive(".ahk - Notepad ahk_exe notepad++.exe") or WinActive(".ahk - Notepad ahk_exe notepad.exe")
	
	~^s::Reload
	
#HotIf WinActive("ahk_exe EXCEL.EXE")
	
	^+q::
	{
		Send "{Right}+{F10}n"
		Sleep 100
		Send "^{Tab}!i{Enter}"
	}
	
	^+w::Send "+{F10}{Down}{Down}{Enter}{Down}"
	