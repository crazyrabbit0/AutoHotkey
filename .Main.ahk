#SingleInstance Force

	debugging := 0
	run_audio_repeater_when_headphones_are_connected()
	
	
	>^/::Reload
	
	>!/::Pause -1
	
	#SuspendExempt True
	>^>!/::Suspend
	#SuspendExempt False
	
	Media_Prev::
	{
		activate_window_under_mouse()
		Send "{Left}"
	}
	Media_Next::
	{
		activate_window_under_mouse()
		Send "{Right}"
	}
	
	$Volume_Up::
	{
		Send "{Volume_Up}"
		set_headphones_volume_same_as_master_volume()
	}
	$Volume_Down::
	{
		Send "{Volume_Down}"
		set_headphones_volume_same_as_master_volume()
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

#HotIf WinExist("Stremio - Freedom to Stream ahk_exe stremio.exe")

	$Media_Play_Pause::
	{
		SetTimer(single_press, -300)
		double_press := A_ThisHotkey == A_PriorHotkey and A_TimeSincePriorHotkey < 300
		if double_press
		{
			SetTimer(single_press, 0)
			active_window_id := WinGetID("A")
			WinActivate("Stremio - Freedom to Stream ahk_exe stremio.exe")
			Send "{Space}"
			WinActivate(active_window_id)
		}
		
		single_press()
		{
			If WinActive("Stremio - Freedom to Stream ahk_exe stremio.exe")
				Send "{Space}"
			else
				Send "{Media_Play_Pause}"
		}
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

set_headphones_volume_same_as_master_volume()
{
	master_volume := SoundGetVolume( , "CABLE Input (VB-Audio Virtual Cable)")
	SoundSetVolume(master_volume, , "Ακουστικά (ZV Headphones Stereo)")
	SoundSetVolume(master_volume, , "Ακουστικά (Evi Headphones Stereo)")
}

activate_window_under_mouse()
{
	MouseGetPos( , , &id_of_window_under_mouse, )
	if not(WinActive("ahk_id " . id_of_window_under_mouse))
		WinActivate("ahk_id " . id_of_window_under_mouse)
}

run_audio_repeater_when_headphones_are_connected()
{
	audiorepeater_path := EnvGet("cr") . "\Programs\Portables\Audio Repeater MME + KS\audiorepeater_ks.exe"
	SplitPath audiorepeater_path, &audiorepeater_file
	audio_render_registry_key := "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render"
	DetectHiddenWindows True
	SetTimer(loop_timer, 500)
	
	loop_timer()
	{
		audiorepeater_has_error := WinExist("Error ahk_exe " . audiorepeater_file)
		if audiorepeater_has_error
			ProcessClose(WinGetPID("ahk_id " . audiorepeater_has_error))
		Loop Reg audio_render_registry_key, "K"
		{
			if debugging
				MsgBox A_LoopRegKey . "`n" . A_LoopRegName . "`n" . A_LoopRegType
			current_registry_key := A_LoopRegKey . "\" . A_LoopRegName
			device_is_bluetooth := RegRead(current_registry_key . "\Properties", "{a45c254e-df1c-4efd-8020-67d146a850e0},24") == "BTHENUM"
			if not(device_is_bluetooth)
				continue
			headphones_name := RegRead(current_registry_key . "\Properties", "{b3f8fa53-0004-438e-9003-51a46e139bfc},6")
			headphones_are_connected := RegRead(current_registry_key, "DeviceState") == 1
			audiorepeater_is_running := WinExist(headphones_name . " ahk_exe " . audiorepeater_file)
			if audiorepeater_is_running and not(headphones_are_connected)
				WinClose("ahk_id " . audiorepeater_is_running)
			if not(headphones_are_connected) or WinExist("Headphones ahk_exe " . audiorepeater_file)
				continue
			if debugging
				MsgBox 'Audio Repeater on "' . headphones_name . '" is not running!  Starting...'
			Run('"' . audiorepeater_path . '" /Input:"VB-Audio Point" /Output:"' . headphones_name . '" /OutputPrefill:70 /SamplingRate:44100 /Priority:"High" /WindowName:"' . headphones_name . '" /AutoStart', , "Hide")
			set_headphones_volume_same_as_master_volume()
		}
	}
}