
;############################## Variables ##############################

    #SingleInstance Force

    debugging := 0
    use_custom_volume := 1

;############################## Includes ##############################

    #Include "Run as Administrator.ahk"
    #Include "Multimedia.ahk"
    ;#Include "Headphones.ahk"
    ;#Include "Mouse Volume.ahk"
    #Include "Text Case.ahk"
    #Include "Prevent Idle.ahk"

;############################## Execute ##############################

    ;Prevent idle on workhours
    prevent_idle(9 * 60 * 1000, '2-6', '8-18')

;############################## Hotkeys ##############################

#HotIf

    /::/

    >^/::Reload

    >!/::Pause -1

    #SuspendExempt True
    >^>!/::Suspend
    #SuspendExempt False

    ^#b:: ; Run 'ms-settings:bluetooth'
    {
        Send "{Blind}{Ctrl up}{LWin up}#a"
        Sleep 1000
        Send "{Right}{Tab}{Enter}"
    }

    ;^!v:: ; Paste with additional text
    ;{
    ;    stringToAdd := "https://192.168.2.5:8081/web/videocall?token="
    ;    If !InStr(A_Clipboard, stringToAdd)
    ;        A_Clipboard := stringToAdd . A_Clipboard
    ;    Send "{Blind}{LAlt up}^v"
    ;}

    >^NumpadDot::
    {
        static toggle := 0
        toggle := !toggle

        if toggle
            SetTimer(press_ctrl_end_and_click, 2000)
        else
            SetTimer(press_ctrl_end_and_click, 0)

        press_ctrl_end_and_click()
        {
            Send "{RCtrl up}^{End}"
            Sleep 500
            Send "{LButton}"
        }
    }

    ; Middle-Click hold -> Send to -> Location open
    *MButton:: {
        if KeyWait("MButton", "T0.2") {   ; released within 0.x secs -> normal middle click
            Click "Middle"
            return
        }
        Click "Right"                     ; held -> open context menu at cursor
        Sleep 150
        Send "n"                          ; "Send to"
        Sleep 150
        Send "l"                          ; first letter of shortcut
    }

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Notepad++ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#HotIf WinActive(".ahk - Notepad ahk_exe notepad++.exe") or WinActive(".ahk - Notepad ahk_exe notepad.exe")

    ~^s::Reload

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Excel ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#HotIf WinActive("ahk_exe EXCEL.EXE")

    ^+q::
    {
        Send "{Ctrl up}{Shift up}{Right}+{F10}n"
        Sleep 100
        Send "^{Tab}!i{Enter}"
    }

    ^+w::Send "{Ctrl up}{Shift up}+{F10}{Down}{Down}{Enter}{Down}"
