	
;############################## Run ##############################
	
	run_audio_repeater_when_headphones_are_connected()
	
;############################## Includes ##############################
	
	#Include "Custom Volume.ahk"
	
;############################## Hotkeys ##############################
	
#HotIf
	
	Hotkey("$Volume_Up", increase_headphones_volume)
	increase_headphones_volume(caller_hotkey)
	{
		increase_volume()
		set_headphones_volume_same_as_virtual_cable_volume()
	}

	Hotkey("$Volume_Down", decrease_headphones_volume)
	decrease_headphones_volume(caller_hotkey)
	{
		decrease_volume()
		set_headphones_volume_same_as_virtual_cable_volume()
	}
	
;############################## Functions ##############################
	
	set_headphones_volume_same_as_virtual_cable_volume()
	{
		If SoundGetName() == "Hi-Fi Cable Input (VB-Audio Hi-Fi Cable)"
		{
			master_volume := SoundGetVolume()
			try {
				SoundSetVolume(master_volume, , "Earphones Short")
				SoundSetVolume(master_volume, , "Earphones Short Hands-Free")
			}
			try {
				SoundSetVolume(master_volume, , "Earphones Long")
				SoundSetVolume(master_volume, , "Earphones Long Hands-Free")
			}
		}
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
				if IsSet(debugging) and debugging
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
				if audiorepeater_is_running or not(headphones_are_connected and playback_device_is_hifi_cable) 
					continue
				if IsSet(debugging) and debugging
					MsgBox 'Audio Repeater on "' . headphones_name . '" is not running!  Starting...'
				Run('"' . audiorepeater_path . '" /Input:"VB-Audio Hi-Fi Cable" /Output:"' . headphones_name . '" /OutputPrefill:70 /SamplingRate:48000 /Priority:"High" /WindowName:"' . headphones_name . '" /AutoStart', , "Min")
				set_headphones_volume_same_as_virtual_cable_volume()
			}
		}
	}
	