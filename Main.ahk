	
;############################## Variables ##############################
	
	#SingleInstance Force
	
	debugging := 0
	use_custom_volume := 1
	
;############################## Includes ##############################
	
	#Include "Run as Administrator.ahk"
	#Include "Multimedia.ahk"
	#Include "Headphones.ahk"
	;#Include "Mouse Volume.ahk"
    #Include "Text Case.ahk"
	
;############################## Hotkeys ##############################

#HotIf
	
	/::/
	
	>^/::Reload
	
	>!/::Pause -1
	
	#SuspendExempt True
	>^>!/::Suspend
	#SuspendExempt False
	
	^#b:: ; Run 'ms-settings:bluetooth'
	{
		Send "{Ctrl up}{LWin up}#a"
		Sleep 1000
		Send "{Right}{Tab}{Enter}"
	}
	
	>^NumpadDot::
	{
		static toggle := 0
		toggle := !toggle
		
		if toggle
			SetTimer(press_ctrl_end_and_click, 2000)
		else
			SetTimer(press_ctrl_end_and_click, 0)

		press_ctrl_end_and_click()
		{
			Send "{RCtrl up}^{End}"
			Sleep 500
			Send "{LButton}"
		}
	}
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Notepad++ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#HotIf WinActive(".ahk - Notepad ahk_exe notepad++.exe") or WinActive(".ahk - Notepad ahk_exe notepad.exe")
	
	~^s::Reload
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Excel ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#HotIf WinActive("ahk_exe EXCEL.EXE")
	
	^+q::
	{
		Send "{Ctrl up}{Shift up}{Right}+{F10}n"
		Sleep 100
		Send "^{Tab}!i{Enter}"
	}
	
	^+w::Send "{Ctrl up}{Shift up}+{F10}{Down}{Down}{Enter}{Down}"
	