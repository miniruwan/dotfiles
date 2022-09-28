; Note that The variable "todo_task_name" needs to be set to use this functionality.

; MatchMode 2: A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode 2

^+F2::
    IfWinActive, cshtml
      Send @* TODO(%todo_task_name%):  *@{Left 3}  ; Razor @**@ comment
    else IfWinActive, sql
      Send -- TODO(%todo_task_name%):{Space} ; SQL -- comment
    else
      Send // TODO(%todo_task_name%):{Space} ; C# // comment

    return

; C# /**/ comment
^!F2::
    Send /* TODO(%todo_task_name%):  */{Left 3}
    return

; Search all (Ctrl Shift f) for the TODO comments with %todo_task_name%
^+F3::
    Send {Ctrl down}{Shift down}f{Ctrl up}{Shift up}TODO(%todo_task_name%)
    return
