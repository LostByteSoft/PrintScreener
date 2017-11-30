;;--- Head --- Informations --- AHK --- File(s) needed ---

;;	ScreenShooter, Just press PrintScreen
;;	NEED "iview442_x64_setup.exe" you could found it here "http://www.irfanview.com/64bit.htm"
;;	Just take a snapshot of the screen AHK
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	2017-04-07 - switch jpg to png format
;;	2017-05-31 - switch png to jpg format
;;	2017-10-20-0837 - mouse hide before take photo - added function Lwin + c mouse disappear/appear

;;--- Softwares var options files ---

	SetWorkingDir, %A_ScriptDir%
	#SingleInstance Force
	#Persistent
	#NoEnv

	SetEnv, title, ScreenShooter
	SetEnv, mode, Just press PrintScreen : HotKey Printscreen
	SetEnv, version, Version 2017-11-25-1641
	SetEnv, Author, LostByteSoft
	SetEnv, interval, 5
	SetEnv, loopback, 0
	SetEnv, number, 1
	SetEnv, icofolder, C:\Program Files\Common Files
	SetEnv, logoicon, ico_camera.ico
	SetEnv, debug, 0

	IniRead, sound, PrintScreener.ini, options, sound
	IniRead, activescreen, PrintScreener.ini, options, activescreen
	IniRead, activewindows, PrintScreener.ini, options, activewindows
	IniRead, allmonitors, PrintScreener.ini, options, allmonitors
	IniRead, interval, PrintScreener.ini, options, interval

	;; specific files

	FileInstall, snd_click.mp3, snd_click.mp3, 0
	FileInstall, PrintScreener.ini, PrintScreener.ini, 0
	FileInstall, ico_camtake.ico, %icofolder%\ico_camtake.ico, 0
	FileInstall, ico_camera.ico, %icofolder%\ico_camera.ico, 0
	FileInstall, ico_folder.ico, %icofolder%\ico_folder.ico, 0
	FileInstall, ico_Sound.ico, %icofolder%\ico_Sound.ico, 0
	FileInstall, ico_monitor.ico, %icofolder%\ico_monitor.ico, 0
	FileInstall, ico_fullscreen.ico, %icofolder%\ico_fullscreen.ico, 0

	;; Common ico

	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, Close					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Set take ACTIVE = %activescreen%, setactive 		; set active printscreen
	Menu, Tray, Icon, Set take ACTIVE = %activescreen%, %icofolder%\ico_fullscreen.ico, 1
	Menu, tray, add, Set take SCREEN = %activewindows%, setscreen 		; set screen printscreen
	Menu, Tray, Icon, Set take SCREEN = %activewindows%, %icofolder%\ico_monitor.ico, 1
	Menu, tray, add, Set all SCREEN = %allmonitors%, setallmonitors
	Menu, tray, add,
	Menu, tray, add, Sound On/Off = %sound%, soundonoff 			; Sound on off
	Menu, Tray, Icon, Sound On/Off = %sound%, %icofolder%\ico_Sound.ico
	Menu, tray, add,
	Menu, tray, add, Interval take On/Off = %loopback%, startstop
	Menu, tray, add, Interval take = %interval% Sec., interval 		; Take at interval.
	Menu, Tray, Icon, Interval take = %interval% Sec., %icofolder%\ico_options.ico
	Menu, tray, add,
	Menu, tray, add, Open Pictures Folder, Open 				; Open where files are saved
	Menu, Tray, Icon, Open Pictures Folder, %icofolder%\ico_folder.ico
	Menu, tray, add, Printscreen Active (Need Click), Printscreen2 			; Take a shot.
	Menu, Tray, Icon, Printscreen Active (Need Click), %icofolder%\ico_camera.ico
	Menu, tray, add, Printscreen (All screen), Printscreen1			; Take a shot.
	Menu, Tray, Icon, Printscreen (All screen), %icofolder%\ico_camera.ico
	Menu, Tray, Tip, Print Screener

;;--- Software start here ---

	TrayTip, %title%, Mouse do not appear : Press Lwin + C !, 1, 2

start:
	Menu, Tray, Icon, %icofolder%\ico_camera.ico
	IfEqual, debug, 1, MsgBox, (atart) A_Username=%A_Username% activescreen=%activescreen% activewindows=%activewindows% allmonitors=%allmonitors% debug=%debug% sound=%sound% number=%number%
	KeyWait, PrintScreen , D
	send, #c

	intervalstart:
		Menu, Tray, Icon, %icofolder%\ico_camtake.ico

	count:
		SetEnv, number, 1
		count1:
		;; Actual user
		;;IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, playsound
		;;IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
		;; Public user
		IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, playsound
		IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
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
		;;run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, user profile img folder
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the screen where the mouse is, PUBLIC img folder
		goto, next

	active:
		IfEqual, debug, 1, MsgBox, (active)
		;;run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, user profile img folder
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=1 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
		goto, next


	allmonitors:
		IfEqual, debug, 1, MsgBox, (allmonitors)
		;;run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, user profile img folder
		run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, PUBLIC img folder
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
		Menu, Tray, Icon, %icofolder%\ico_camera.ico
		IfEqual, loopback, 1, sleep, %interval%000
		IfEqual, loopback, 1, goto, intervalstart
		Sleep, 125		; needed mouse reappear to fast
		send, #c
		Goto, start

printtrayall:
	send, #c
	Menu, Tray, Icon, %icofolder%\ico_camtake.ico
	IfEqual, debug, 1, sleep, 2000
	count2:
	;;IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, take2
	;;IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, take2
	IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	goto, count2

	take2:
	IfEqual, sound, 0, goto, soundskip2
	SoundPlay, snd_click.mp3
	soundskip2:
	;;run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, user profile img folder
	run, C:\Program Files\IrfanView\i_view64.exe "/capture=0 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; whole screen, PUBLIC img folder
	Sleep, 125		; needed mouse reappear to fast
	send, #c
	goto, start

printtrayactive:
	TrayTip, %title%, Click on a Windows with left mouse button !, 1, 2
	KeyWait, LButton, D
	send, #c
	Menu, Tray, Icon, %icofolder%\ico_camtake.ico
	IfEqual, debug, 1, sleep, 2000
	count3:
	;;IfNotExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, goto, take3
	;;IfExist, C:\Users\%A_Username%\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	IfNotExist, C:\Users\Public\Pictures\Picture_%number%.jpg, goto, take3
	IfExist, C:\Users\Public\Pictures\Picture_%number%.jpg, EnvAdd, number, 1
	goto, take3

	take3:
	IfEqual, sound, 0, goto, soundskip3
	SoundPlay, snd_click.mp3
	soundskip3:
	;;run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\%A_Username%\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, user profile img folder
	run, C:\Program Files\IrfanView\i_view64.exe "/capture=2 /jpgq=100 /convert=C:\Users\Public\Pictures\Picture_%number%.jpg", ,hide ;; ONLY the active windows, PUBLIC img folder
	Sleep, 125		; needed mouse reappear to fast
	send, #c
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

;;--- Founctions ---

#c::SystemCursor("Toggle") 		 ; Win+C hotkey to toggle the cursor on and off.

SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors
    if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
    {
        $ = h                                          ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor   := DllCall( "LoadCursor", "Ptr",0, "Ptr",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage", "Ptr",h_cursor, "UInt",2, "Int",0, "Int",0, "UInt",0 )
            b%A_Index% := DllCall( "CreateCursor", "Ptr",0, "Int",0, "Int",0
                , "Int",32, "Int",32, "Ptr",&AndMask, "Ptr",&XorMask )
        }
    }
    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
        $ = b  ; use blank cursors
    else
        $ = h  ; use the saved cursors

    Loop %c0%
    {
        h_cursor := DllCall( "CopyImage", "Ptr",%$%%A_Index%, "UInt",2, "Int",0, "Int",0, "UInt",0 )
        DllCall( "SetSystemCursor", "Ptr",h_cursor, "UInt",c%A_Index% )
    }
}

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Goto, sleep2

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Goto, sleep2

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	goto, sleep

	unpaused:	
	Menu, Tray, Icon, %logoicon%
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Quit (escape , esc)

Close:
	ExitApp

doReload:
	Reload
	sleep, 500
	goto, Close

;Escape::	; for debug purposes
	Goto, Close

;;--- Tray Bar (must be at end of file) ---

secret:
	Menu, Tray, Icon, %icofolder%\ico_camtake.ico
	SoundPlay, snd_click.mp3
	MsgBox, 48, Printscreen SECRET MsbBox, title=%title% mode=%mode% version=%version% author=%author%`n`nA_WorkingDir=%A_WorkingDir%`n`nactivescreen=%activescreen% activewindows=%activewindows% allmonitors=%allmonitors% sound=%sound% interval=%interval% loopback=%loopback% number=%number% NEWnumber=YMDHMS`n`nSet take active print the active windows. Set take screen print the screen where the mouse is. If you have more than 1 monitor set to ALL SCREEN to take ALL screen in one image.
	Menu, Tray, Icon, %icofolder%\ico_camera.ico
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
	;;run, explorer.exe C:\Users\%A_Username%\Pictures\
	run, explorer.exe C:\Users\Public\Pictures\
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
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
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