#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconTip := "Screen Off"

; --- Tray icon (Windows built-in) ---
try TraySetIcon(A_WinDir "\System32\imageres.dll", 110, true)  ; true = freeze icon

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
    ; wait for every trigger key/button so its release doesn't wake the screen
    for key in ["LWin", "RWin", "Shift", "m", "LButton"]
        KeyWait key, "T2"
    Sleep 1000                             ; let trailing input settle
    ; post to one window instead of a blocking broadcast: a hung app can't stall us
    try PostMessage 0x0112, 0xF170, 2,, "Program Manager"  ; WM_SYSCOMMAND, SC_MONITORPOWER, 2 = off
}
