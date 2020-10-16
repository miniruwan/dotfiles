; Note that The variable "todo_task_name" needs to be set to use this functionality.

^+F2::
    IfWinActive, cshtml
      Send @* TODO(%todo_task_name%):  *@{Left 3}  ; Razor @**@ comment
    else
      Send // TODO(%todo_task_name%):{Space} ; C# // comment

    return

; C# /**/ comment
^!F2::
    Send /* TODO(%todo_task_name%):  */{Left 3}
    return
