#SingleInstance Force
#Include "Run as Administrator.ahk"

	debugging := 0
	run_audio_repeater_when_headphones_are_connected()
	
	/::/
	
	>^/::Reload
	
	>!/::Pause -1
	
	#SuspendExempt True
	>^>!/::Suspend
	#SuspendExempt False
	
	$Media_Prev::
	{
		activate_window_under_mouse()
		Send "{Left}"
	}
	$Media_Next::
	{
		activate_window_under_mouse()
		Send "{Right}"
	}
	
	^!+p::Send "{Shift down}p{Shift up}"
	^!+n::Send "{Shift down}n{Shift up}"
	
	$Volume_Up::
	{
		Send "{Volume_Up}"
		set_headphones_volume_same_as_virtual_cable_volume()
	}
	$Volume_Down::
	{
		Send "{Volume_Down}"
		set_headphones_volume_same_as_virtual_cable_volume()
	}
	
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

stremio_title := "Stremio - Freedom to Stream"
#HotIf WinExist(stremio_title)

	$Media_Play_Pause::
	{
		static key_presses := 0
		if key_presses > 0
		{
			key_presses++
			return
		}
		key_presses := 1
		SetTimer key_press, -400
		
		key_press()
		{
			if key_presses = 1
			{
				If WinActive(stremio_title)
					Send "{Space}"
				else
					Send "{Media_Play_Pause}"
			}
			else if key_presses = 2
			{
				ControlClick , stremio_title, , "MIDDLE"
				ControlSend "{Space}", , stremio_title
			}
			key_presses := 0
		}
	}

potplayer_title := "ahk_class PotPlayer64"
#HotIf WinExist(potplayer_title)
	
	^!+p::
	{
		ControlClick , potplayer_title, , "MIDDLE"
		ControlSend "{Media_Prev}", , potplayer_title
	}
	^!+n::
	{
		ControlClick , potplayer_title, , "MIDDLE"
		ControlSend "{Media_Next}", , potplayer_title
	}

#HotIf WinActive("ahk_exe EXCEL.EXE")

	^+q::
	{
		Send "{Right}+{F10}n"
		Sleep 100
		Send "^{Tab}!i{Enter}"
	}
	
	^+w::Send "+{F10}{Down}{Down}{Enter}{Down}"


;------------------------------ Functions ------------------------------

#Include "Headphone Functions.ahk"

activate_window_under_mouse()
{
	MouseGetPos( , , &id_of_window_under_mouse, )
	if not(WinActive("ahk_id " . id_of_window_under_mouse))
		WinActivate("ahk_id " . id_of_window_under_mouse)
}
