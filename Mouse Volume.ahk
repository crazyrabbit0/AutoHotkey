	
;------------------------------ Hotkeys ------------------------------

#HotIf
	
	~LButton & WheelUp::
	{
		SoundSetVolume "+5"
		display_volume()
	}

	~LButton & WheelDown::
	{
		SoundSetVolume "-5"
		display_volume()
	}
	
	~RButton & WheelUp::
	{
		SoundSetMute false
		display_volume("Unmuted")
	}

	~RButton & WheelDown::
	{
		SoundSetMute true
		display_volume("Muted")
	}
	
;------------------------------ Functions ------------------------------
	
	display_volume(text?)
	{
		If Not IsSet(text)
			text := Round(SoundGetVolume()) "%"
		static id := 0
		id++
		volume_gui := Gui("-Caption +AlwaysOnTop +Owner +LastFound", "Volume Gui " id)
		volume_gui.BackColor := "fff"
		WinSetTransColor("fff")
		volume_gui.SetFont("s60 Bold q5 c49b0fd")
		volume_gui.Add("Text", , "Volume " text)
		volume_gui.Show("NA")
		SetTimer(() => volume_gui.Destroy(), -2000)
		If WinExist("Volume Gui ahk_exe AutoHotkey64.exe", , id)
			WinKill()
	}
	