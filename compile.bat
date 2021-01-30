@echo Compile version 2021-01-28
@taskkill /im "PrintScreener.exe"
@PATH C:\Program Files\AutoHotkey\Compiler;C:\windows\system32
@if not exist "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" goto notins
Ahk2Exe.exe /in "PrintScreener.ahk" /out "PrintScreener.exe" /icon "ico_camera.ico" /mpress "0"
@goto exit

:notins
@echo Ahk is not installed.
@pause

:exit
InstallPrtSrc.bat
@exit