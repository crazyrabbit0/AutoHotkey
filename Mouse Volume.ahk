	
;############################## Includes ##############################
	
	#Include "Custom Volume.ahk"
	
;############################## Hotkeys ##############################

#HotIf
	
	~LButton & WheelUp::
	{
		increase_volume()
	}

	~LButton & WheelDown::
	{
		decrease_volume()
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
	