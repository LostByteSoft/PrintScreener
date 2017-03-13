;;--- Head --- Informations --- AHK --- File(s) needed ---

;;	ScreenShooter, Just press PrintScreen
;;	NEED "iview442_x64_setup.exe" you could found it here "http://www.irfanview.com/64bit.htm"
;;	Just take a snapshot of the screen AHK
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares options ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent

;;--- Softwares Var ---

	SetEnv, title, ScreenShooter
	SetEnv, mode, Just press PrintScreen : HotKey Printscreen
	SetEnv, version, Version 2017-03-11
	SetEnv, Author, LostByteSoft
	SetEnv, interval, 5
	SetEnv, loopback, 0
	SetEnv, number, 1
	IniRead, activescreen, PrintScreener.ini, options, activescreen
	IniRead, activewindows, PrintScreener.ini, options, activewindows
	IniRead, sound, PrintScreener.ini, options, sound

;;--- Softwares files ---

	FileInstall, click.mp3, click.mp3, 0
	FileInstall, PrintScreener.ini, PrintScreener.ini, 0
	FileInstall, ico_camtake.ico, ico_camtake.ico, 0
	FileInstall, ico_camera.ico, ico_camera.ico, 0
	FileInstall, ico_about.ico, ico_about.ico, 0
	FileInstall, ico_folder.ico, ico_folder.ico, 0
	FileInstall, ico_Sound.ico, ico_Sound.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_monitor.ico, ico_monitor.ico, 0
	FileInstall, ico_fullscreen.ico, ico_fullscreen.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, Hotkey: Printscreen, intervalstart		; Show hotkey
	Menu, Tray, Icon, Hotkey: Printscreen, ico_camera.ico, 1
	Menu, tray, add, Exit PrintScreener, GuiClose			; GuiClose exit program
	Menu, Tray, Icon, Exit PrintScreener, ico_shut.ico
	Menu, tray, add, Refresh, doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh, ico_reboot.ico, 1
	Menu, tray, add, Secret MsgBox, secret				; empty space
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico, 1
	Menu, tray, add,
	Menu, tray, add, About LostByteSoft, about1 			; Creates a new menu item.
	Menu, Tray, Icon, About LostByteSoft, ico_about.ico, 1
	Menu, tray, add, Version, Version 				; Show version
	Menu, Tray, Icon, Version, ico_about.ico, 1
	Menu, tray, add,
	Menu, tray, add, Interval take On/Off = %loopback%, startstop
	Menu, tray, add, Interval take = %interval% Sec., interval 	; Take at interval.
	Menu, tray, add, Interval stop, stop	 			; stop interval.
	Menu, tray, add,
	Menu, tray, add, Set take ACTIVE = %activescreen%, setactive 	; set active printscreen
	Menu, Tray, Icon, Set take ACTIVE = %activescreen%, ico_fullscreen.ico, 1
	Menu, tray, add, Set take SCREEN = %activewindows%, setscreen 	; set screen printscreen
	Menu, Tray, Icon, Set take SCREEN = %activewindows%, ico_monitor.ico, 1
	Menu, tray, add, Sound On/Off = %sound%, soundonoff 		; Sound on off
	Menu, Tray, Icon, Sound On/Off = %sound%, ico_Sound.ico, 1
	Menu, tray, add,
	Menu, tray, add, Open Pictures Folder, Open 			; Open where files are saved
	Menu, Tray, Icon, Open Pictures Folder, ico_folder.ico, 1
	Menu, tray, add, Printscreen (PrtScr), Printscreen 		; Take a shot.
	Menu, Tray, Icon, Printscreen (PrtScr), ico_camera.ico, 1
	Menu, Tray, Tip, Print Screener

;;--- Software start here ---

start:
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
		msgbox, Error (variable?) %activewindows% %activescreen% : Must one variable to be 1 and another to be 0.

	active:
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
		goto, next

	screen:
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

startstop:
	IfEqual, loopback, 1, goto, stop
	SetEnv, loopback, 1
	Menu, Tray, Rename, Interval take On/Off = 0, Interval take On/Off = 1
	goto, intervalstart

stop:
	SetEnv, loopback, 0
	Menu, Tray, Rename, Interval take On/Off = 1, Interval take On/Off = 0
	Return

soundonoff:
	IfEqual, sound, 1, goto, disablesound
	IfEqual, sound, 0, goto, enablesound
	msgbox, error_02 sound error sound=%sound%
	Goto, Start

	enablesound:
	SoundPlay, click.mp3, wait
	IniWrite, 1, PrintScreener.ini, options, sound
	SetEnv, sound, 1
	TrayTip, %title%, Sound enabled %sound%, 2, 2
	Menu, Tray, Rename, Sound On/Off = 0, Sound On/Off = 1
	Goto, Start

	disablesound:
	IniWrite, 0, PrintScreener.ini, options, sound
	SetEnv, sound, 0
	TrayTip, %title%, Sound disabled %sound%, 2, 2
	Menu, Tray, Rename, Sound On/Off = 1, Sound On/Off = 0
	Goto, Start

;;--- Quit (escape , esc)

GuiClose:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_camtake.ico
	SoundPlay, click.mp3
	MsgBox,0,Printscreen SECRET MENU, title=%title% mode=%mode% version=%version% author=%author%`n`nA_WorkingDir=%A_WorkingDir%`n`nactivescreen=%activescreen% activewindows=%activewindows% sound=%sound% interval=%interval% loopback=%loopback% number=%number%`n`nIf you have more than 1 monitor it take only the screen where the mouse is.
	Menu, Tray, Icon, ico_camera.ico
	Return

interval:
	SetEnv, oldinterval, %interval%
	SetEnv, oldloopback, %loopback%
	InputBox, interval, Printscreener, Change the time period to auto-take snapshot. 1 to 200 seconds. Default 5 if you enter nothing. Press OK to start snapshot at %oldinterval% or new value., , , , , , , 10, Enter number
	if ErrorLevel
	goto, start
	IfEqual, interval, , Goto, interval
	IfEqual, interval, Enter number, SetEnv, interval, 5
	IfLess,interval, 1, Goto, interval
	IfGreater, interval, 200, Goto, interval
	SetEnv, loopback, 1
	Menu, Tray, Rename, Interval take = %oldinterval% Sec., Interval take = %interval% Sec.
	Menu, Tray, Rename, Interval take On/Off = 0, Interval take On/Off = 1
	goto, intervalstart

about1:
about2:
about3:
about4:
	TrayTip, %title%, Just press PrintScreen by %Author%, 2, 2
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
	Menu, Tray, Rename, Set take ACTIVE = 0, Set take ACTIVE = 1
	Menu, Tray, Rename, Set take SCREEN = 1, Set take SCREEN = 0
	Return

setscreen:
	IniWrite, 0, PrintScreener.ini, options, activewindows
	IniWrite, 1, PrintScreener.ini, options, activescreen
	SetEnv, activewindows, 0
	SetEnv, activescreen, 1
	Menu, Tray, Rename, Set take ACTIVE = 1, Set take ACTIVE = 0
	Menu, Tray, Rename, Set take SCREEN = 0, Set take SCREEN = 1
	Return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;;--- End of f       