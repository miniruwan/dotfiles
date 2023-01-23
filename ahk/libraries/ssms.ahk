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