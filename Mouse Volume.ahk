	
;############################## Includes ##############################
	
	#Include "Custom Volume.ahk"
	
;############################## Hotkeys ##############################

#HotIf
	
	~LButton & WheelUp::increase_volume()

	~LButton & WheelDown::decrease_volume()
	
	~RButton & WheelUp::unmute_volume()

	~RButton & WheelDown::mute_volume()
	