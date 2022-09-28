#include %A_LineFile%\..\libraries\todo_comment.ahk

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; https://github.com/rcmdnk/vim_ahk.git
VimGroup := "ahk_exe notepad.exe,ahk_exe Ssms.exe"
#include C:\packages\AutoHotKey\vim_ahk\vim.ahk



; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; https://www.autohotkey.com/download/AutoCorrect.ahk
#include C:\packages\AutoHotKey\AutoCorrect.ahk



; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Control & j::Send {Down}
Control & k::Send {Up}

Capslock::Esc

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



; ++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
Create a new branch starting with common branch prefix
using GitKraken
*/
#ifWinActive, ahk_exe gitkraken.exe

^+B::
    Send {Ctrl down}b{Ctrl up}
    Send feature/%git_branch_prefix%/     ; feature branch prefix
    return

^!B::
    Send {Ctrl down}b{Ctrl up}
    Send bug/%git_branch_prefix%/     ; bug branch prefix
    return

#IfWinActive



; ++++++++++++++++++++++++++++++++++++++++++++
/*
Launch Tasky plugin of Launchy
*/
!Capslock::Send {Alt down}{Space}{Alt up}t{Tab}



; ++++++++++++++++++++++++++++++++++++++++++++
/*
Toggle Window Scaling
Reference : https://github.com/lihas/windows-DPI-scaling-sample.git
*/
^!F8::ToggleWindowScaling()
	
ToggleWindowScaling()
{
	Run, "%packages_dir%\windows-DPI-scaling-sample\x64\Debug\DPIScalingMFCApp.exe"
	WinWaitActive, DPIScalingMFCApp
	ControlGetText, currentDpi, Edit2, DPIScalingMFCApp
	if(currentDpi == 100)
    {
		Send, {Tab} {Down 2} {Tab} {Enter} ; 100 to 150
	}
    else
    {
		Send, {Tab} {Up 2} {Tab} {Enter} ; 150 to 100
	}
	WinClose, DPIScalingMFCApp
}



; ++++++++++++++++++++++++++++++++++++++++++++
/*
Google search the highlighted text
*/
#f::
    Send ^c
    Run, chrome.exe --profile-directory="%chrome_personal_profile_directory%" "http://www.google.com/search?hl=en&q=%Clipboard%"
    return
