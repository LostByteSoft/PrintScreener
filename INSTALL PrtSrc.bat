echo off
pushd "%~dp0
@echo -------------------------===== Install Start. =====-------------------------
echo You must run this in run as administrator mode.
@echo -------------------------------------
echo PrintScreener
echo LostByteSoft
echo Install version 2025-10-31-06-53-56
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11 (and servers)
@echo -------------------------------------
if exist "C:\Program Files\IrfanView\i_view64.exe" goto copy
iview450_x64_setup.exe /silent
@echo -------------------------------------
:copy
tasklist /FI "IMAGENAME eq PrintScreener.exe" | findstr /I "PrintScreener.exe"
if %ERRORLEVEL% equ 0 (
    echo PrintScreener.exe is running. Attempting to terminate...
    taskkill /IM "PrintScreener.exe" /F
    if %ERRORLEVEL% equ 0 (
        echo PrintScreener.exe terminated successfully.
    ) else (
        echo Failed to terminate PrintScreener.exe.
    )
) else (
    echo PrintScreener.exe is not running.
)
@echo -------------------------------------
@echo copy "ProgIcons\*.ico" "C:\Program Files\Common Files"
copy "ProgIcons\*.ico" "C:\Program Files\Common Files"
@echo copy "SharedIcons\*.ico" "C:\Program Files\Common Files"
copy "SharedIcons\*.ico" "C:\Program Files\Common Files"
@echo -------------------------------------
copy "*.mp3" "C:\Program Files\Common Files\"
copy "PrintScreener.exe" "C:\Program Files\"
copy "*.lnk" "C:\Users\Public\Desktop\"
@echo -------------------------------------
@echo Take ownership of StartUpFireFox.ini
takeown /F "C:\Program Files\PrintScreener.ini.ini" /A
cmd.exe /C icacls "C:\Program Files\PrintScreener.ini" /grant Everyone:F
@echo -------------------------------------
@echo Install complete. Now start !
echo "You must close this command windows"
@echo ------------------------===== Install end. =====-----------------------
"C:\Program Files\PrintScreener.exe"
exit
