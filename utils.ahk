#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 200
SendMode Input


; Fix for weird issue on my PC
NumpadDot::.


CapsLock & C::
	PlaintextClipboardEnabled := !PlaintextClipboardEnabled
	if (PlaintextClipboardEnabled) {
		Clipboard := Clipboard ; assigns text part of clipboard to clipboard
		MsgBox, Plaintext Clipboard Enabled
	} else {
		MsgBox, Plaintext Clipboard Disabled
	}
return

OnClipboardChange:
	if (PlaintextClipboardEnabled) {
		Clipboard := Clipboard ; assigns text part of clipboard to clipboard
	}
return


; Allows use of CapsLock as modifier
; Press Shift + CapsLock to use old CapsLock functionality
CapsLock::return
CapsLock & Tab::Tab


; Quick Command Prompt
CapsLock & T::
	if (GetKeyState("Shift", "P")) {		; If shift down
		Run, "Command Prompt Admin",,, pid
	} else {								; If shift up
		Run, "Command Prompt",,, pid
	}
	WinWait, ahk_pid %pid%
	WinActivate, ahk_pid %pid%
return


; Sleep
CapsLock & L::
	Send, #x
	Send, u
	Send, s
return


; Quick GHCi
CapsLock & H::
	Run, hs.bat,,, pid
	WinWait, ahk_pid %pid%
	WinActivate, ahk_pid %pid%
return


; Quick JShell
CapsLock & J::
	Run, jshell,,, pid
	WinWait, ahk_pid %pid%
	WinActivate, ahk_pid %pid%
return


; Quick Python shell
CapsLock & P::
	Run, py,,, pid
	WinWait, ahk_pid %pid%
	WinActivate, ahk_pid %pid%
return


; Quick Everything
; Requires configuration in voidtools Everything:
; Show window Hotkey: ALT+F15
CapsLock & Q::!F15


; Show/hide hidden files
#IfWinActive ahk_exe explorer.exe
^H::SendInput, !vhh
#IfWinActive


; Media controls
CapsLock & WheelUp::Volume_Up
CapsLock & WheelDown::Volume_Down
CapsLock & MButton::Media_Play_Pause
CapsLock & Volume_Down::Media_Prev
CapsLock & Volume_Up::Media_Next
Pause::Media_Play_Pause

; Silence PgUp/PgDn because of annoying key placement on my laptop
PgUp::return
CapsLock & PgUp::PgUp
PgDn::return
CapsLock & PgDn::PgDn


SwitchTo(pid) {
	WinWait, ahk_pid pid
	WinActivate, ahk_pid pid
}

; Returns selected text or selects a word and returns that
GetWord() {
	ClipboardOriginal := ClipboardAll
	clipboard := ""
	SendInput, ^c
	ClipWait, 1
	if (clipboard == "") {
		SendInput, {Right}^{Left}^+{Right}
		SendInput, ^c
		ClipWait, 1
	}
	word := clipboard
	clipboard := ClipboardOriginal
	return word
}

; Enter a unicode character from it's code
CapsLock & U::
	Send, {Insert}
	Input, code,, {Enter}
	Send, {Insert}
	if (SubStr(code, 1, 1) == "d") { ; if decimal
		code := SubStr(code, 2)				; remove leading x
		code := Format("{:X}", code)		; convert to hex
	}
	SendInput, {U+%code%}
Return

; Insert accent
CapsLock & `::
	SendInput, {U+301}
Return