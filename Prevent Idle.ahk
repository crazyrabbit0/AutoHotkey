    
;############################## Functions ##############################
	
	prevent_idle(idle_time := 15 * 60 * 1000, days := '1-7', hours := '0-23')
    {
        timer_time := idle_time / 3
        
        days := StrSplit(days, '-')
        if !days.Has(2)
            days.Push(7)
        ;MsgBox days[1] ' ' days[2]
        is_in_days := A_WDay >= days[1] && A_WDay <= days[2]
        
        hours := StrSplit(hours, '-')
        if !hours.Has(2)
            hours.Push(23)
        ;MsgBox hours[1] ' ' hours[2]
        is_in_hours := A_Hour >= hours[1] && A_Hour <= hours[2]
        
        timer_loop()
        {   
            is_idle := A_TimeIdle > idle_time
            
            if is_idle && is_in_days && is_in_hours
            {
                ;MsgBox is_idle ' ' is_in_days ' ' is_in_hours
                Send "{Blind}{vkE8}" ;Send an unassigned virtual key (vkE8)
            }
        }
        
        SetTimer(timer_loop, timer_time)
    }
    