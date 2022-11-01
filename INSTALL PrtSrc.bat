echo off
pushd "%~dp0
@echo -------------------------------------
echo LostByteSoft
echo Install version 2.2 2021-06-23
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11

echo PrintScreener
@echo ----------------------------------------------------------

taskkill /im "PrintScreener.exe"

if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent

:copy
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"

echo "You must close this command windows"
"C:\Program Files\PrintScreener.exe"
exit
