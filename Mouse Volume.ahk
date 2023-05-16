	
;------------------------------ Hotkeys ------------------------------

#HotIf
	
	~LButton & WheelUp::
	{
		SoundSetVolume "+1"
		display_volume()
	}

	~LButton & WheelDown::
	{
		SoundSetVolume "-1"
		display_volume()
	}
	
	~RButton & WheelUp::
	{
		SoundSetMute false
		display_volume()
	}

	~RButton & WheelDown::
	{
		SoundSetMute true
		display_volume("")
	}
	
;------------------------------ Functions ------------------------------
	
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
		WinSetTransColor("1 170")
		volume_gui.SetFont("s100 Bold q5 cffffff")
		volume_gui.Add("Text", , text)
		volume_gui.Show("NA") ; "Y " 0)
		SetTimer(() => Try volume_gui.Destroy(), -500)
		Try old_volume_gui.Destroy()
	}
	