@PATH C:\Program Files\AutoHotkey;C:\Program Files\AutoHotkey\Compiler;C:\windows\system32
@taskkill /im "PrintScreener.exe"
@if not exist "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" goto notins
@if exist "C:\Program Files\AutoHotkey\Compiler\mpress.exe" goto mpress

@echo Mpress IS NOT installed.
Ahk2Exe.exe /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /in PrintScreener.ahk" /out "PrintScreener.exe" /icon "ProgIcons/ico_camera.ico" /mpress "0"
@goto exit

:mpress
@echo Mpress installed.
Ahk2Exe.exe /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /in "PrintScreener.ahk" /out "PrintScreener.exe" /icon "ProgIcons/ico_camera.ico" /mpress "1"
@goto exit

:notins
@echo Ahk is not installed.
@goto exit

:exit
@echo Sleep 3 seconds ...
@timeout /t 3 /nobreak >nul
@exit
