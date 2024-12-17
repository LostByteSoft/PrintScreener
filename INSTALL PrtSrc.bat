echo off
pushd "%~dp0
@echo -------------------------===== Install Start. =====-------------------------
echo LostByteSoft
echo Install version 2.2 2024-12-17
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11

echo PrintScreener
@echo -------------------------===== Install iview450_x64 =====-------------------------
if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent
@echo -------------------------===== Separator =====-------------------------
:copy
@taskkill /im "PrintScreener.exe"
@echo -------------------------===== Copy files =====-------------------------
copy "SharedIcons\*.ico" "C:\Program Files\Common Files\"
copy "ProgramIcons\*.ico" "C:\Program Files\Common Files\"
copy "*.mp3" "C:\Program Files\Common Files\"
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"
@echo -------------------------===== Separator =====-------------------------
@echo Install complete. Now start !
echo "You must close this command windows"
@echo -------------------------===== Install end. =====-------------------------
"C:\Program Files\PrintScreener.exe"
exit
