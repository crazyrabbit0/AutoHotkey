	
;############################## Hotkeys ##############################
	
#HotIf
	
    ;Ctrl + Alt + 1:  Convert selected text to "UPPER CASE"
    ^!1::SetCase("upper")
    
    ;Ctrl + Alt + 2:  Convert selected text to "lower case"
    ^!2::SetCase("lower")
    
    ;Ctrl + Alt + 3:  Convert selected text to "Title Case"
    ^!3::SetCase("title")
    
;############################## Functions ##############################
	
	SetCase( text_Case )
    {
        if (!text_Case)
            return
        
        A_Clipboard := ""
        Send "^c"
        ClipWait
        switch text_Case, "Off"
        {
            case "upper": A_Clipboard := StrUpper(A_Clipboard)
            case "lower": A_Clipboard := StrLower(A_Clipboard)
            case "title": A_Clipboard := StrTitle(A_Clipboard)
        }
        Send "^v"
    }
    