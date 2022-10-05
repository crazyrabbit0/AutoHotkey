#HotIf WinActive("ahk_exe Darksiders3-Win64-Shipping.exe")
	
	NumpadDot::
	{
		static toggle := 0
		toggle := !toggle
		if toggle
			SetTimer(press_second_mouse_side_button, 500)
		else
			SetTimer(press_second_mouse_side_button, 0)
		
		press_second_mouse_side_button()
		{
			Send "{XButton2}"
		}
	}
