	
;############################## Run ##############################
	
	initialize_volume_gui()
	
;############################## Hotkeys ##############################
	
#HotIf
	
	$Volume_Up::increase_volume()

	$Volume_Down::decrease_volume()
	
	$Volume_Mute::mute_toggle()
	
;############################## Functions ##############################
	
	DetectHiddenWindows True
	
	initialize_volume_gui()
	{
		global volume_gui := Gui("-Caption +AlwaysOnTop +Owner +LastFound", "Volume Gui")
		volume_gui.MarginX := 40
		volume_gui.MarginY := 30
		volume_gui.BackColor := "0"
		WinSetTransColor("1 175")
		volume_gui.SetFont("s100 Bold q5 cffffff")
		volume_gui.Add("Text", "Center w400")
	}
	
	show_volume(text?)
	{
		If Not IsSet(text)
			text := ((SoundGetMute() = True) ? "" : "") " " Round(SoundGetVolume())
		text_control := "Static1"
		volume_gui[text_control].Text := text
		If Not ControlGetVisible(text_control, "Volume Gui")
			volume_gui.Show("NA AutoSize")
		SetTimer(() => volume_gui.Hide(), -500)
	}
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ +/- Volume ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	increase_volume()
	{
		If IsSet(use_custom_volume) and use_custom_volume
		{
			SoundSetVolume "+2"
			show_volume()
		}
		Else
			Send "{Volume_Up}"
	}
	
	decrease_volume()
	{
		If IsSet(use_custom_volume) and use_custom_volume
		{
			SoundSetVolume "-2"
			show_volume()
		}
		Else
			Send "{Volume_Down}"
	}
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mute ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	mute_volume()
	{
		If IsSet(use_custom_volume) and use_custom_volume
		{
			SoundSetMute true
			show_volume("")
		}
		Else
			Send "{Volume_Mute}"
	}
	
	unmute_volume()
	{
		If IsSet(use_custom_volume) and use_custom_volume
		{
			SoundSetMute false
			show_volume()
		}
		Else
			Send "{Volume_Mute}"
	}
	
	mute_toggle()
	{
		If SoundGetMute()
			unmute_volume()
		Else
			mute_volume()
	}
	