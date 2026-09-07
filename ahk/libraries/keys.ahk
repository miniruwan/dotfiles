#Requires AutoHotkey v2.0
#SingleInstance Force

; ===========================================================
;  Home-row navigation layer
;    Hold CapsLock + hjkl...  -> arrows and navigation keys
;    Tap  CapsLock            -> Escape
;    Shift + CapsLock         -> toggle real CapsLock on/off
; ===========================================================

CapsIsReal := false   ; true only while genuine all-caps mode is active
ArmCapsLock()         ; start disarmed: CapsLock can't lock, it's a layer key


; ---------- the navigation layer ---------------------------
; "CapsLock & x" turns CapsLock into a prefix key. Its own
; keypress is held back until release, so it never types
; anything on its way to being a modifier.

CapsLock & h::Send "{Left}"
CapsLock & j::Send "{Down}"
CapsLock & k::Send "{Up}"
CapsLock & l::Send "{Right}"

CapsLock & u::Send "{PgUp}"
CapsLock & d::Send "{PgDn}"
CapsLock & i::Send "{Home}"
CapsLock & o::Send "{End}"

CapsLock & n::Send "{Backspace}"
CapsLock & m::Send "{Delete}"


; ---------- bare tap ---------------------------------------
; Normally sends Escape. But if you're mid all-caps, a plain
; tap is almost certainly you trying to switch caps off the
; usual way, so honour that instead of firing Escape.

CapsLock:: {
    if CapsIsReal {
        ArmCapsLock()
        Notify("CAPS OFF")
    } else {
        Send "{Escape}"
    }
}


; ---------- Shift+CapsLock: the all-caps toggle -------------

+CapsLock:: {
    if CapsIsReal {
        ArmCapsLock()
        Notify("CAPS OFF")
    } else {
        UnlockCapsLock()
        Notify("CAPS ON")
    }
}


; ---------- helpers ----------------------------------------

; Disarm: force the lock off and keep it off. While this
; attribute is set, CapsLock physically cannot lock, which is
; what makes it safe to use as a layer key.
ArmCapsLock() {
    global CapsIsReal
    SetCapsLockState "AlwaysOff"
    CapsIsReal := false
}

; Re-enable: clear the AlwaysOff attribute first, otherwise
; the request to switch it on is ignored, then turn it on for
; real. The keyboard LED lights up as your indicator.
UnlockCapsLock() {
    global CapsIsReal
    SetCapsLockState()
    SetCapsLockState true
    CapsIsReal := true
}

; Brief on-screen confirmation, cleared after 800ms.
Notify(text) {
    ToolTip text
    SetTimer () => ToolTip(), -800
}