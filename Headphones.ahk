	
	run_audio_repeater_when_headphones_are_connected()
	
;------------------------------ Hotkeys ------------------------------
	
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
	
;------------------------------ Functions ------------------------------
	
	set_headphones_volume_same_as_virtual_cable_volume()
	{
		;If SoundGetName() == "Hi-Fi Cable Input (VB-Audio Hi-Fi Cable)"
		;{
			master_volume := SoundGetVolume()
			SoundSetVolume(master_volume, , "Ακουστικά (ZV Headphones Stereo)")
			SoundSetVolume(master_volume, , "Σετ Ακουστικών (ZV Headphones Hands-Free AG Audio)")
			SoundSetVolume(master_volume, , "Ακουστικά (Evi Headphones Stereo)")
			SoundSetVolume(master_volume, , "Σετ Ακουστικών (Evi Headphones Hands-Free AG Audio)")
		;}
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
			playback_device_is_hifi_cable := SoundGetName() == "Hi-Fi Cable Input (VB-Audio Hi-Fi Cable)"
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
				if audiorepeater_is_running and not(headphones_are_connected and playback_device_is_hifi_cable)
					WinClose("ahk_id " . audiorepeater_is_running)
				if WinExist("Headphones ahk_exe " . audiorepeater_file) or not(headphones_are_connected and playback_device_is_hifi_cable) 
					continue
				if debugging
					MsgBox 'Audio Repeater on "' . headphones_name . '" is not running!  Starting...'
				Run('"' . audiorepeater_path . '" /Input:"VB-Audio Hi-Fi Cable" /Output:"' . headphones_name . '" /OutputPrefill:70 /SamplingRate:44100 /Priority:"High" /WindowName:"' . headphones_name . '" /AutoStart', , "Hide")
				set_headphones_volume_same_as_virtual_cable_volume()
			}
		}
	}
	