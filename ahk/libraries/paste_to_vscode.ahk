#Requires AutoHotkey v2.0


#^v:: { ; Win + Ctrl + V
    Run("code") ; Open VSCode
    WinWaitActive("ahk_exe Code.exe")

    ; Wait until window title contains "Welcome"
    Loop 10 {
        winTitle := WinGetTitle("ahk_exe Code.exe")
        if InStr(winTitle, "Welcome") {
            break
        }
        Sleep(300)
    }

    ; Retry sending Ctrl+N until a new untitled file appears
    Loop 5 {
        Send("^n") ; Send Ctrl+N (new file)
        Sleep(500)

        ; Check if the title contains 'Untitled'
        winTitle := WinGetTitle("ahk_exe Code.exe")
        if InStr(winTitle, "Untitled") {
            break
        }
    }

    ; Once ready, paste clipboard contents
    Send("^v")
}