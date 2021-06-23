echo off
pushd "%~dp0
@echo -------------------------------------
echo LostByteSoft
echo Install version 2.1 2021-06-23
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11

echo PrintScreener
@echo ----------------------------------------------------------
if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent
@echo ----------------------------------------------------------
:copy
@taskkill /im "PrintScreener.exe"
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