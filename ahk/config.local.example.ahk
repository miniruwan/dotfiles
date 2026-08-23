; +++++++++++++++++++++++++++++++++++++++++++++++++++++++
; Set the variables needed and includ the needed scripts

; Comment out the stuff you don't need
; =======================================================

#Requires AutoHotkey v2.0

; 1. Press Shift + Caps Lock to toggle standard Caps Lock behavior
+Capslock::SetCapsLockState !GetKeyState("CapsLock", "T")

; 2. Press Caps Lock alone to send Escape
Capslock::Send("{Esc}")

chrome_personal_profile_directory := "Default" 
#include %A_LineFile%\..\libraries\web_search.ahk

todo_task_name := "my-task"
#include %A_LineFile%\..\libraries\todo_comment.ahk

;packages_dir := "C:\Packages" 
;#include %A_LineFile%\..\libraries\window_scaling.ahk

;#include %A_LineFile%\..\libraries\ssms.ahk

#include %A_LineFile%\..\libraries\cosmos.ahk
;#include %A_LineFile%\..\libraries\postman.ahk

#include %A_LineFile%\..\libraries\paste_to_vscode.ahk