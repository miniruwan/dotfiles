/*
Send 2 combinations to the following tool when pressed mouse middle button
https://www.screen-marker-recorder.com/
*/
#HotIf WinActive("ahk_exe ScreenPaint.exe", )

    MButton::    Send("{Ctrl down}{Shift down}xd{Ctrl up}{Shift up}")

#HotIf