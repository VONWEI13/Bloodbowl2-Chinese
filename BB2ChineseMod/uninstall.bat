@echo off
chcp 936 >nul
setlocal
title Blood Bowl 2 Chinese Localization Uninstaller

set "GAMEDIR=%~dp0..\"
if not exist "%GAMEDIR%BloodBowl2.exe" goto :NOGAME
if not exist "%~dp0backup\Default_loc_English.db" goto :NOBACKUP

copy /y "%~dp0backup\Default_loc_English.db" "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" >nul
if errorlevel 1 goto :RESTOREFAIL
echo [OK] 已还原原始英文语言库

for %%F in (
  "Gui\Fonts\fonts.xml"
  "Gui\Fonts\FontBB2_TRUMP_TOWN_PRO.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-REGULAR.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-SEMIBOLD.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-ITALIC.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-BOLDITALIC.TTF"
  "Gui\Fonts\FontBB2_ROBOTOCONDENSED-BOLD.TTF"
  "Gui\Fonts\FontBB2_KELLYSLAB-REGULAR.TTF"
  "Gui\Fonts\FontBB2_LOBSTER.TTF"
  "Gui\Fonts\FontBB2_COURIERNEW.TTF"
  "Gui\Fonts\english\FontBB2_TRUMP_TOWN_PRO.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-REGULAR.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-SEMIBOLD.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-ITALIC.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-BOLDITALIC.TTF"
  "Gui\Fonts\english\FontBB2_ROBOTOCONDENSED-BOLD.TTF"
  "Gui\Fonts\english\FontBB2_KELLYSLAB-REGULAR.TTF"
  "Gui\Fonts\english\FontBB2_LOBSTER.TTF"
  "Gui\Fonts\english\FontBB2_COURIERNEW.TTF"
) do (
  if exist "%GAMEDIR%Data\%%~F" del /f /q "%GAMEDIR%Data\%%~F"
)
dir /b "%GAMEDIR%Data\Gui\Fonts\english" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui\Fonts\english" 2>nul
dir /b "%GAMEDIR%Data\Gui\Fonts" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui\Fonts" 2>nul
dir /b "%GAMEDIR%Data\Gui" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui" 2>nul
echo [OK] 已清理中文字体文件
echo.
echo 卸载完成，游戏已恢复英文原版。
pause
exit /b 0

:NOGAME
echo [错误] 未找到游戏目录，请确认 BB2ChineseMod 在游戏根目录内
pause
exit /b 1
:NOBACKUP
echo [错误] 找不到原始备份 backup\Default_loc_English.db
pause
exit /b 1
:RESTOREFAIL
echo [错误] 还原语言库失败
pause
exit /b 1
