/*
Filter by partition key value in Azure Cosmos DB Data Explorer

Usage: While the cursor is in the middle of partitionKey, press Ctrl + Alt + c
    For an example, when the cursor is in the following position, press the above key combination.
        "parti<<CURSOR_POSITION>>tionKey": "WorkplaceLink-AP-4AFFCF25-A69C-4E80-AD81-71316884684A",
*/
#IfWinActive, cdb-  ; If the window title starts with "cdb-"" Eg title: "cdb-test-au01-test-custprf - Microsoft Azure and 7 more pages"

    !^c::           ; When Alt + Ctrl + c is pressed

        ; Assuming cursor is anywhere in the middle of partitionKey, move the cursor and select partitionKey value
        ; Example cursor position: "parti<<CURSOR_POSITION>>tionKey": "WorkplaceLink-AP-4AFFCF25-A69C-4E80-AD81-71316884684A",
        Send {Ctrl down}{Right 2}{Ctrl up}{Right 2}{Shift down}{End}{Left 2}{Shift up}

        Send ^c     ; Copy (above selected partitionKey value) using Ctrl + c
        ClipWait    ; Wait for the clipboard to contain text

        ; Get user input if user wants to filter on a different partitionKey value
        InputBox, partitionKey, Partition Key,Enter the partition key you want to filter on,,420,120,,,,,%clipboard%
        if ErrorLevel
            return

        ; The following trick is to move the focus out from the document editor and get focus on the Query input of the page
        Send {Esc}    ; to leave focus from editor
        Send ^f       ; to enter browser search
        Send select * from
        Send {Esc}    ; to leave focus from browser search
        Send {Tab}
        Send {Space}  ; In case query input is not there, and edit filter button is there, press it

        SendRaw WHERE c.partitionKey = "%partitionKey%" ORDER BY c._ts DESC
        Send {Tab}
        Send {Space}  ; Click Apply Filter button
        return

#IfWinActive