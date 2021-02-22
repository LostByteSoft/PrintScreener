@echo ----------------------------------------------------------
@echo LostByteSoft
@echo Version 2021-02-22
@echo ----------------------------------------------------------
@taskkill /im "PrintScreener.exe"
@echo ----------------------------------------------------------
if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent
@echo ----------------------------------------------------------
:copy
copy "SharedIcons\*.ico" "C:\Program Files\Common Files\"
copy "ProgramIcons\*.ico" "C:\Program Files\Common Files\"
copy "*.mp3" "C:\Program Files\Common Files\"
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"
@echo ----------------------------------------------------------
@echo Install complete. Now start !
@echo ----------------------------------------------------------
echo "You must close this command windows"
@echo ----------------------------------------------------------
"C:\Program Files\PrintScreener.exe"
exit