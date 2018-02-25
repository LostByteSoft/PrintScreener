@taskkill /f /im "PrintScreener.exe"
@echo Install IrfanView 64 by default
@echo Version 2018-02-18-1301
@echo ---------------------------------------------------------
@if exist "C:\Program Files\IrfanView\i_view64.exe" goto skip
"iview450_x64_setup.exe" /silent /desktop=0 /thumbs=0 /group=0 /allusers=0 /assoc=0 /assocallusers
:skip
copy "PrintScreener.exe" "C:\Program Files\IrfanView\"
copy "*.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
@echo ---------------------------------------------------------
@if exist "C:\PrintScreener" goto skipfolder
mklink /j C:\PrintScreener "C:\Users\%USERNAME%\Pictures"
:skipfolder
@echo ---------------------------------------------------------
@echo You can close this windows.
@"C:\Program Files\IrfanView\PrintScreener.exe"
@exit