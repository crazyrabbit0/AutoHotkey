#SingleInstance Force
#Include ".Run as Administrator.ahk"

	debugging := 0
	run_audio_repeater_when_headphones_are_connected()
	
	
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

#HotIf WinExist("Stremio - Freedom to Stream")

	$Media_Play_Pause::
	{
		SetTimer(single_press, -300)
		double_press := A_ThisHotkey == A_PriorHotkey and A_TimeSincePriorHotkey < 300
		if double_press
		{
			SetTimer(single_press, 0)
			ControlClick , "Stremio - Freedom to Stream", , "MIDDLE"
			ControlSend "{Space}", , "Stremio - Freedom to Stream ahk_exe stremio.exe"
		}
		
		single_press()
		{
			If WinActive("Stremio - Freedom to Stream")
				Send "{Space}"
			else
				Send "{Media_Play_Pause}"
		}
	}

#HotIf WinExist("ahk_class PotPlayer64")
	
	<+p::
	{
		ControlClick , "ahk_class PotPlayer64", , "MIDDLE"
		ControlSend "{Media_Prev}", , "ahk_class PotPlayer64"
	}
	<+n::
	{
		ControlClick , "ahk_class PotPlayer64", , "MIDDLE"
		ControlSend "{Media_Next}", , "ahk_class PotPlayer64"
	}

#HotIf WinActive("ahk_exe EXCEL.EXE")

	^+q::
	{
		Send "+{F10}n"
		Sleep 100
		Send "^{Tab}!i{Enter}{Right}"
	}
	
	^+w::Send "+{F10}{Down}{Down}{Enter}{Down}"


;------------------------------ Functions ------------------------------

#Include ".Headphones Functions.ahk"

activate_window_under_mouse()
{
	MouseGetPos( , , &id_of_window_under_mouse, )
	if not(WinActive("ahk_id " . id_of_window_under_mouse))
		WinActivate("ahk_id " . id_of_window_under_mouse)
}
