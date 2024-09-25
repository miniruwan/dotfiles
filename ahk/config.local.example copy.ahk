; +++++++++++++++++++++++++++++++++++++++++++++++++++++++
; Set the variables needed and includ the needed scripts

; Comment out the stuff you don't need
; =======================================================

;^Esc::CapsLock

chrome_personal_profile_directory := "Default" 
#include %A_LineFile%\..\libraries\web_search.ahk

todo_task_name := "my-task"
#include %A_LineFile%\..\libraries\todo_comment.ahk

;packages_dir := "C:\Packages" 
;#include %A_LineFile%\..\libraries\window_scaling.ahk

;#include %A_LineFile%\..\libraries\ssms.ahk

#include %A_LineFile%\..\libraries\cosmos.ahk
;#include %A_LineFile%\..\libraries\postman.ahk