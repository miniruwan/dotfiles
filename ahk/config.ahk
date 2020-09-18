; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; https://github.com/rcmdnk/vim_ahk.git
VimGroup := "ahk_exe notepad.exe,ahk_exe Ssms.exe"
#include D:\packages\vim_ahk\vim.ahk

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; https://www.autohotkey.com/download/AutoCorrect.ahk
#include D:\packages\AutoHotKey\AutoCorrect.ahk


; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Control & j::Send {Down}
Control & k::Send {Up}

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
Enable "Select Top 1000 Rows" for middle mouse button in SSMS

When middle mouse button is clicked,
Send right click, 3 down arrows and enter
(This key sequence is for "Select Top 1000 Rows")
if Ssms.exe (Sql Server Management Studio is open.
This key sequence is for "Select Top 1000 Rows" functionality
*/
#ifWinActive, ahk_exe Ssms.exe
MButton::Send {RButton}{Down 3}{Enter}
#IfWinActive

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
Launch Tasky plugin of Launchy
*/
!Escape::Send {Alt down}{Space}{Alt up}t{Tab}

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
Toggle Window Scaling
Reference : https://github.com/lihas/windows-DPI-scaling-sample.git
*/
^+F7::ToggleWindowScaling()
	
ToggleWindowScaling()
{
	Run, "D:\packages\windows-DPI-scaling-sample\x64\Debug\DPIScalingMFCApp.exe"
	WinWaitActive, DPIScalingMFCApp
	ControlGetText, currentDpi, Edit2, DPIScalingMFCApp
	if(currentDpi == 100) {
		Send, {Tab} {Down 2} {Tab} {Enter} ; 100 to 150
	} else {
		Send, {Tab} {Up 2} {Tab} {Enter} ; 150 to 100
	}
	WinClose, DPIScalingMFCApp
}
