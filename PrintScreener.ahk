;;--- Head --- Informations --- AHK --- File(s) needed ---

;;	ScreenShooter, Just press PrintScreen
;;	NEED "iview442_x64_setup.exe" you could found it here "http://www.irfanview.com/64bit.htm"
;;	Just take a snapshot of the screen AHK
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	2017-04-07 - switch jpg to png format
;;	2017-05-31 - switch png to jpg format

;;--- Softwares var options files ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv

	SetEnv, title, ScreenShooter
	SetEnv, mode, Just press PrintScreen : HotKey Printscreen
	SetEnv, version, Version 2017-10-18-1029
	SetEnv, Author, LostByteSoft
	SetEnv, interval, 5
	SetEnv, loopback, 0
	SetEnv, number, 1
	SetEnv, logoicon, ico_camera.ico
	SetEnv, debug, 0

	IniRead, sound, PrintScreener.ini, options, sound
	IniRead, activescreen, PrintScreener.ini, options, activescreen
	IniRead, activewindows, PrintScreener.ini, options, activewindows
	IniRead, allmonitors, PrintScreener.ini, options, allmonitors
	IniRead, interval, PrintScreener.ini, options, interval

	FileInstall, snd_click.mp3, snd_click.mp3, 0
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
	FileInstall, ico_HotKeys.ico, ico_HotKeys.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_debug.ico, ico_debug.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, ico_options.ico
	Menu, tray, add, Exit %title%, Close					; Close exit program
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, ico_options.ico
	Menu, tray, add, Set take ACTIVE = %activescreen%, setactive 		; set active printscreen
	Menu, Tray, Icon, Set take ACTIVE = %activescreen%, ico_fullscreen.ico, 1
	Menu, tray, add, Set take SCREEN = %activewindows%, setscreen 		; set screen printscreen
	Menu, Tray, Icon, Set take SCREEN = %activewindows%, ico_monitor.ico, 1
	Menu, tray, add, Set all SCREEN = %allmonitors%, setallmonitors
	Menu, tray, add,
	Menu, tray, add, Sound On/Off = %sound%, soundonoff 			; Sound on off
	Menu, Tray, Icon, Sound On/Off = %sound%, ico_Sound.ico
	Menu, tray, add,
	Menu, tray, add, Interval take On/Off = %loopback%, startstop
	Menu, tray, add, Interval take = %interval% Sec., interval 		; Take at interval.
	Menu, Tray, Icon, Interval take = %interval% Sec., ico_options.ico
	Menu, tray, add,
	Menu, tray, add, Open Pictures Folder, Open 				; Open where files are saved
	Menu, Tray, Icon, Open Pictures Folder, ico_folder.ico
	Menu, tray, add, Printscreen Active (Need Click), Printscreen2 			; Take a shot.
	Menu, Tray, Icon, Printscreen Active (Need Click), ico_camera.ico
	Menu, tray, add, Printscreen (All screen), Printscreen1			; Take a shot.
	Menu, Tray, Icon, Printscreen (All screen), ico_camera.ico
	Menu, Tray, Tip, Print Screener

;;--- Software start here ---

start:
	Menu, Tray, Icon, ico_camera.ico
	IfEqual, debug, 1, MsgBox, (atart) A_Username=%A_Username% activescreen=%activescreen% activewindows=%activewindows% allmonitors=%allmonitors% debug=%debug% sound=%sound% number=%number%
	KeyWait, PrintScreen , D

	intervalstart:
		Menu, Tray, Icon, ico_camtake.ico

	count:
		SetEnv, number, 1
		count1:
		;; Actual user
		IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, playsound
		IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
		;; Public user
		;IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, playsound
		;IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
		goto, count1

	playsound:
		IfEqual, sound, 0, goto, soundskip
		SoundPlay, snd_click.mp3

	soundskip:
		IfEqual, debug, 1, MsgBox, (soundskip) activescreen=%activescreen% activewindows=%activewindows% allmonitors=%allmonitors%
		IniRead, activescreen, PrintScreener.ini, options, activescreen
		IniRead, activewindows, PrintScreener.ini, options, activewindows
		IniRead, allmonitors, PrintScreener.ini, options, allmonitors

		IfEqual, activescreen, 1, goto, screen
		IfEqual, activewindows, 1, goto, active
		IfEqual, allmonitors, 1, goto, allmonitors

		msgbox, Error (variable?) %activewindows% %activescreen% %allmonitors%: Must one variable to be 1 and another to be 0.

	screen:
		IfEqual, debug, 1, MsgBox, (screen)
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, user profile img folder
		;run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, PUBLIC img folder
		goto, next

	active:
		IfEqual, debug, 1, MsgBox, (active)
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, user profile img folder
		;run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
		goto, next


	allmonitors:
		IfEqual, debug, 1, MsgBox, (allmonitors)
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, user profile img folder
		;run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, PUBLIC img folder
		goto, next

		;;  0 = whole screen
		;;  1 = current monitor
		;;  2 = foreground window
		;;  3 = foreground window - client area
		;;  4 = rectangle selection
		;;  5 = object selected with the mouse
		;;  6 = start in capture mode (can't be combined with other commandline options)
		;;  $U(%d%m%Y_%H%M%S) - %Y%m%d%H%M%S
		;;  view i_options.txt for all options

	next:
		Sleep, 250
		Menu, Tray, Icon, ico_camera.ico
		IfEqual, loopback, 1, sleep, %interval%000
		IfEqual, loopback, 1, goto, intervalstart
		Goto, start

printtrayall:
	;SetEnv, number, 1
	Menu, Tray, Icon, ico_camtake.ico
	count2:
	IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, take2
	IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	;IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, take2
	;IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	goto, count2

	take2:
	run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, user profile img folder
	;run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, PUBLIC img folder
	goto, start

printtrayactive:
	TrayTip, %title%, Click on a Windows with left mouse button !, 1, 2
	KeyWait, LButton, D
	;SetEnv, number, 1
	Menu, Tray, Icon, ico_camtake.ico
	count3:
	IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, take3
	IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	;IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, take3
	;IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	goto, take3

	take3:
	run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, user profile img folder
	;run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
	goto, start

startstop:
	IfEqual, loopback, 1, goto, stop
	SetEnv, oldloopback, %loopback%
	SetEnv, loopback, 1
	Menu, Tray, Rename, Interval take On/Off = %oldloopback%, Interval take On/Off = 1
	goto, intervalstart

	stop:
	SetEnv, oldloopback, %loopback%
	SetEnv, loopback, 0
	Menu, Tray, Rename, Interval take On/Off = %oldloopback%, Interval take On/Off = 0
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
	;SetEnv, loopback, 1
	Menu, Tray, Rename, Interval take = %oldinterval% Sec., Interval take = %interval% Sec.
	IniWrite, %interval%, PrintScreener.ini, options, interval
	goto, start

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, debug=%debug%, 1, 2
	goto, start

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, debug=%debug%, 1, 2
	goto, start

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	goto, sleep

	unpaused:	
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, ico_pause.ico
	sleep, 24000
	goto, sleep


;;--- Quit (escape , esc)

Close:
	ExitApp

doReload:
	Reload
	sleep, 500
	goto, Close

;; Escape	; for debug purposes
	Goto, Close

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, ico_camtake.ico
	SoundPlay, snd_click.mp3
	MsgBox, 48, Printscreen SECRET MsbBox, title=%title% mode=%mode% version=%version% author=%author%`n`nA_WorkingDir=%A_WorkingDir%`n`nactivescreen=%activescreen% activewindows=%activewindows% allmonitors=%allmonitors% sound=%sound% interval=%interval% loopback=%loopback% number=%number% NEWnumber=YMDHMS`n`nSet take active print the active windows. Set take screen print the screen where the mouse is. If you have more than 1 monitor set to ALL SCREEN to take ALL screen in one image.
	Menu, Tray, Icon, ico_camera.ico
	Return

about:
	TrayTip, %title%, Just press PrintScreen by %Author%, 2, 2
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author% This software is usefull when windows goes off the sreen resolution and dissapear. New displacement (if 1) move to %var1% %var3% %var2% %var4% (if 0) move to %var1% %var3% (Automatic calculating according to your screen resolution.).`n`n`tGo to https://github.com/LostByteSoft
	Return

Printscreen1:
	goto, printtrayall
	Return

Printscreen2:
	goto, printtrayactive
	Return

open:
	run, explorer.exe C:\Users\%A_Username%\Pictures\
	;run, explorer.exe C:\Users\Public\Pictures\
	Return

setactive:
	IniWrite, 0, PrintScreener.ini, options, activewindows
	IniWrite, 1, PrintScreener.ini, options, activescreen
	IniWrite, 0, PrintScreener.ini, options, allmonitors
	SetEnv, activewindows, 1
	SetEnv, activescreen, 0
	SetEnv, allmonitors, 0
	Reload
	Exitapp

setscreen:
	IniWrite, 1, PrintScreener.ini, options, activewindows
	IniWrite, 0, PrintScreener.ini, options, activescreen
	IniWrite, 0, PrintScreener.ini, options, allmonitors
	SetEnv, activewindows, 0
	SetEnv, activescreen, 1
	SetEnv, allmonitors, 0
	Reload
	Exitapp

setallmonitors:
	IniWrite, 0, PrintScreener.ini, options, activewindows
	IniWrite, 0, PrintScreener.ini, options, activescreen
	IniWrite, 1, PrintScreener.ini, options, allmonitors
	SetEnv, activewindows, 0
	SetEnv, activescreen, 0
	SetEnv, allmonitors, 1
	Reload
	Exitapp

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , ico_camera.ico
	Gui, Show, w450 h450, %title% Logo
	Gui, Color, 000000
	return

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
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is included in your anus. Look carefully you
;             might miss all theses small characters.
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
;	If you are unhappy with this software i do not care.
;
;;---                     