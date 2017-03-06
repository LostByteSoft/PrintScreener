;;--- Head --- AHK ---
;; ScreenShooter, Just press PrintScreen
;; NEED "iview442_x64_setup.exe" found it here http://www.irfanview.com/64bit.htm
;; Just take a snapshot of the screen AHK

	SetEnv, title, ScreenShooter
	SetEnv, mode, Just press PrintScreen : HotKey Printscreen
	SetEnv, version, Version 2017-03-06
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	#Persistent
	#SingleInstance force

	SetEnv, interval, 5
	SetEnv, loopback, 0
	SetEnv, number, 1
	IniRead, activescreen, PrintScreener.ini, options, activescreen
	IniRead, activewindows, PrintScreener.ini, options, activewindows
	IniRead, sound, PrintScreener.ini, options, sound

;;--- Tray options ---

	Menu, tray, add, Refresh, doReload 		; Reload the script.
	Menu, tray, add, --------, secret		; empty space
	Menu, tray, add, About, about1 			; Creates a new menu item.
	Menu, tray, add, Version, Version 		; Show version
	Menu, tray, add, Sound On/Off, soundonoff 	; Sound on off
	Menu, tray, add, +-------, about2		; empty space
	Menu, tray, add, Interval take, interval 	; Take at interval.
	Menu, tray, add, Interval stop, stop	 	; stop interval.
	Menu, tray, add, ++------, about3		; empty space
	Menu, tray, add, Set Active, setactive 		; set active printscreen
	Menu, tray, add, Set Screen, setscreen 		; set screen printscreen
	Menu, tray, add, +++-----, about4		; empty space
	Menu, tray, add, Open Folder, Open 		; Open where files are saved
	Menu, tray, add, Printscreen (PrtScr), Printscreen 	; Take a shot.

;;--- Software start here ---

start:
	;;MsgBox, START activescreen=%activescreen% activewindows=%activewindows% number=%number%
	KeyWait, PrintScreen , D
	intervalstart:
	Menu, Tray, Icon, ico_camtake.ico

	count:
		IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, playsound
		IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
		goto, count

	playsound:
		IfEqual, sound, 0, goto, soundskip
		SoundPlay, click.mp3

	soundskip:
		IniRead, activescreen, PrintScreener.ini, options, activescreen
		IniRead, activewindows, PrintScreener.ini, options, activewindows
		IfEqual, activewindows, 1, goto, active
		IfEqual, activescreen, 1, goto, screen
		msgbox, Error (variable?) %activewindows% %activescreen%

	active:
		;; msgbox, SCREEN activescreen=%activescreen% activewindows=%activewindows% number=%number%
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
		goto, next

	screen:
		;; msgbox, SCREEN activescreen=%activescreen% activewindows=%activewindows% number=%number%
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, PUBLIC img folder
		goto, next

	next:
		Sleep, 250
		Menu, Tray, Icon, ico_camera.ico
		IfEqual, loopback, 1, sleep, %interval%000
		IfEqual, loopback, 1, goto, intervalstart
		Goto, start

	printtray:
		Menu, Tray, Icon, ico_camtake.ico
		count2:
		IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, playsound2
		IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
		goto, count2
		playsound2:
		IfEqual, sound, 0, goto, soundskip2
		SoundPlay, click.mp3
		soundskip2:
		sleep, 250
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, PUBLIC img folder
		Menu, Tray, Icon, ico_camera.ico
		goto, start

;;--- Quit (escape , esc)

GuiClose:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_camtake.ico
	SoundPlay, click.mp3
	MsgBox,0,Printscreen SECRET MENU, activescreen=%activescreen% activewindows=%activewindows% sound=%sound% interval=%interval% loopback=%loopback% A_WorkingDir=%A_WorkingDir% number=%number% author=%author%
	Menu, Tray, Icon, ico_camera.ico
	Return

soundonoff:
	IfEqual, sound, 1, goto, disablesound
	IfEqual, sound, 0, goto, enablesound
	msgbox, error_02 sound error sound=%sound%
	Return
	enablesound:
	IniWrite, 1, PrintScreener.ini, options, sound
	SetEnv, sound, 1
	TrayTip, %title%, Sound enabled %sound%, 2, 2
	Return
	disablesound:
	IniWrite, 0, PrintScreener.ini, options, sound
	SetEnv, sound, 0
	TrayTip, %title%, Sound disabled %sound%, 2, 2
	Return

stop:
	SetEnv, loopback, 0
	Return

interval:
	InputBox, interval, Printscreener, Change the time period to auto-take snapshot. 1 to 200 seconds. Default 5 if you enter nothing, , , , , , , 10, Enter number
	if ErrorLevel
	goto, start
	IfEqual, interval, , Goto, interval
	IfEqual, interval, Enter number, SetEnv, interval, 5
	IfLess,interval, 1, Goto, interval
	IfGreater, interval, 200, Goto, interval
	SetEnv, loopback, 1
	goto, intervalstart

about1:
about2:
about3:
about4:
	TrayTip, %title%, Just press PrintScreen, 2, 2
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

Printscreen:
	goto, printtray
	Return

open:
	run, explorer.exe C:\Users\Public\Pictures\
	Return

doReload:
	Reload
	Goto, start

setactive:
	IniWrite, 1, PrintScreener.ini, options, activewindows
	IniWrite, 0, PrintScreener.ini, options, activescreen
	SetEnv, activewindows, 1
	SetEnv, activescreen, 0
	Return

setscreen:
	IniWrite, 0, PrintScreener.ini, options, activewindows
	IniWrite, 1, PrintScreener.ini, options, activescreen
	SetEnv, activewindows, 0
	SetEnv, activescreen, 1
	Return

;;--- End of script ---

;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;                    Version 2, December 2004
 
; Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
 
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
 
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
;              You just DO WHAT THE FUCK YOU WANT TO.

;;--- End of file ---