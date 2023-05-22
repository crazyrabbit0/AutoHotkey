	
;############################## Hotkeys ##############################
	
#HotIf
	
	$Volume_Up::
	{
		increase_volume()
	}

	$Volume_Down::
	{
		decrease_volume()
	}
	
	$Volume_Mute::
	{
		mute_volume()
	}
	
;############################## Functions ##############################
	
	display_volume(text?)
	{
		If Not IsSet(text)
			text := ((SoundGetMute() = True) ? "" : "") " " Round(SoundGetVolume())
		static volume_gui
		Try old_volume_gui := volume_gui
		volume_gui := Gui("-Caption +AlwaysOnTop +Owner +LastFound", "Volume Gui ")
		volume_gui.MarginX := 40
		volume_gui.MarginY := 30
		volume_gui.BackColor := "0"
		WinSetTransColor("1 180")
		volume_gui.SetFont("s100 Bold q5 cffffff")
		volume_gui.Add("Text", , text)
		volume_gui.Show("NA") ; "Y " 0)
		SetTimer(() => try_to_destroy(volume_gui), -500)
		Try old_volume_gui.Destroy()
		
		try_to_destroy(gui)
		{
			Try gui.Destroy()
		}
	}
	
	increase_volume()
	{
	
		If IsSet(display_custom_volume) and display_custom_volume
		{
			SoundSetVolume "+1"
			display_volume()
		}
		Else
			Send "{Volume_Up}"
	}
	
	decrease_volume()
	{
	
		If IsSet(display_custom_volume) and display_custom_volume
		{
			SoundSetVolume "-1"
			display_volume()
		}
		Else
			Send "{Volume_Down}"
	}
	
	mute_volume()
	{
	
		If IsSet(display_custom_volume) and display_custom_volume
		{
			If SoundGetMute()
			{
				SoundSetMute false
				display_volume()
			}
			Else
			{
				SoundSetMute true
				display_volume("")
			}
		}
		Else
			Send "{Volume_Mute}"
	}
	