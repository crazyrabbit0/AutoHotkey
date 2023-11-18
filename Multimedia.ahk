	
;############################## Hotkeys ##############################
	
#HotIf
	
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
	
	^!+Left::
	{
		activate_window_under_mouse()
		Send "{Ctrl up}{Alt up}{Shift up}+{Left}"
	}
	
	^!+Right::
	{
		activate_window_under_mouse()
		Send "{Ctrl up}{Alt up}{Shift up}+{Right}"
	}
	
	^!+p::Send "{Ctrl up}{Alt up}{Shift up}+p"
	
	^!+n::Send "{Ctrl up}{Alt up}{Shift up}+n"
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Stremio ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	stremio_title := "Stremio - ahk_exe stremio.exe"
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
		SetTimer(key_press, -400)
		
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
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PotPlayer ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	potplayer_title := "ahk_class PotPlayer64"
#HotIf WinExist(potplayer_title)
	
	^!+p::
	{
		ControlClick , potplayer_title, , "MIDDLE"
		ControlSend "{Ctrl up}{Alt up}{Shift up}{Media_Prev}", , potplayer_title
	}
	
	^!+n::
	{
		ControlClick , potplayer_title, , "MIDDLE"
		ControlSend "{Ctrl up}{Alt up}{Shift up}{Media_Next}", , potplayer_title
	}
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Youtube ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	youtube_title := " - YouTube - Google Chrome"
#HotIf WinActive(youtube_title)
	
	^!+Left::
	{
		ControlSend "{Ctrl up}{Alt up}{Shift up}j", , youtube_title
	}
	
	^!+Right::
	{
		ControlSend "{Ctrl up}{Alt up}{Shift up}l", , youtube_title
	}
	
;############################## Functions ##############################
	
	activate_window_under_mouse()
	{
		MouseGetPos( , , &id_of_window_under_mouse)
		if not(WinActive("ahk_id " . id_of_window_under_mouse))
			WinActivate("ahk_id " . id_of_window_under_mouse)
	}
	