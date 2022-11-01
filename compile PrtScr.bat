@echo ----------------------------------------------------------
@echo Compile version 2021-06-23
@echo ----------------------------------------------------------
@taskkill /im "PrintScreener.exe"
@echo ----------------------------------------------------------
@PATH C:\Program Files\AutoHotkey\Compiler;C:\windows\system32
@if not exist "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" goto notins
Ahk2Exe.exe /in "PrintScreener.ahk" /out "PrintScreener.exe" /icon "ProgramIcons\ico_camera.ico" /mpress "0"
@echo ----------------------------------------------------------
@goto exit

:notins
@echo Ahk is not installed.
@pause

:exit
pause
@exit