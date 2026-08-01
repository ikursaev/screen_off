#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconTip := "Screen Off"

; --- Tray icon (Windows built-in) ---
TraySetIcon("C:\Windows\System32\imageres.dll", 110, true)  ; true = freeze icon

; --- Tray menu ---
menuText := "Screen off`tWin+Shift+M"
A_TrayMenu.Delete()
A_TrayMenu.Add(menuText, ScreenOff)
A_TrayMenu.Add("Exit", (*) => ExitApp())
A_TrayMenu.Default := menuText
A_TrayMenu.ClickCount := 1                 ; single left-click = screen off

; --- Hotkey ---
#+m::ScreenOff()                           ; Win+Shift+M

ScreenOff(*) {
    Sleep 300
    KeyWait "LWin"                         ; wait for releases so the
    KeyWait "Shift"                        ; key-up doesn't wake the screen
    DllCall("user32\SendMessageW"
        , "ptr", 0xFFFF                    ; HWND_BROADCAST
        , "uint", 0x0112                   ; WM_SYSCOMMAND
        , "ptr", 0xF170                    ; SC_MONITORPOWER
        , "ptr", 2)                        ; 2 = off
}
