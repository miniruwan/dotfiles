/*

*/
;#ifWinActive, ahk_exe Postman.exe

    ^Space:: ; Ctrl + Space

        ;if(A_Cursor != "Unknown") ; Mouse is not on a tickbox
        ;    return
        
        ;Click

        ;While, A_Cursor == "Unknown"
{
        MouseMove(50, -50, 10, "R") ;moves the mouse in a box
        MouseMove(-100, 0, 10, "R") ;around it's starting position
        MouseMove(0, 100, 10, "R")
        MouseMove(100, 0, 10, "R")
        MouseMove(0, -100, 10, "R")
        MouseMove(-50, 50, 10, "R")

;#IfWinActive
}
