	
;############################## Functions ##############################
	
	SetBrightness( brightness := 50, timeout := 1 )
	{
		if ( brightness >= 0 && brightness <= 100 )
		{
			For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
				property.WmiSetBrightness( timeout, brightness )	
		}
		else if ( brightness > 100 )
		{
			SetBrightness(100)
		}
		else if ( brightness < 0 )
		{
			SetBrightness(0)
		}
	}

	GetBrightness()
	{
		For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
			currentBrightness := property.CurrentBrightness	

		return currentBrightness
	}
	