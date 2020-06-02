echo off
echo Version 2020-06-02
echo LostByteSoft

taskkill /im "PrintScreener.exe"

ifexist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent

:copy
copy "SharedIcons\*.ico" "C:\Program Files\Common Files\"
copy "ProgramIcons\*.ico" "C:\Program Files\Common Files\"
copy "*.ico" "C:\Program Files\Common Files\"
taskkill /im "PrintScreener.exe"
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"

echo "You must close this command windows"
"C:\Program Files\PrintScreener.exe"
exit