@echo Version 2021-01-27
@echo LostByteSoft (CopyMiddle)

taskkill /im "PrintScreener.exe"

if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent

:copy
copy "SharedIcons\*.ico" "C:\Program Files\Common Files\"
copy "ProgramIcons\*.ico" "C:\Program Files\Common Files\"
copy "*.ico" "C:\Program Files\Common Files\"
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"
@echo Install complete. Now start !
@pause

echo "You must close this command windows"
"C:\Program Files\PrintScreener.exe"
exit