@echo off
chcp 936 >nul
setlocal EnableDelayedExpansion
title Blood Bowl 2 Chinese Localization Installer

set "GAMEDIR=%~dp0..\"
if not exist "%GAMEDIR%BloodBowl2.exe" goto :NOGAME

if exist "%~dp0backup\Default_loc_English.db" goto :HAVEBACKUP
mkdir "%~dp0backup" 2>nul
copy /y "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" "%~dp0backup\" >nul 2>&1
if errorlevel 1 goto :BACKUPFAIL
echo [1/3] 已备份原始英文语言库到 backup\
goto :DEPLOY
:HAVEBACKUP
echo [1/3] 发现已有的原始备份，跳过备份
:DEPLOY
xcopy /y /e /i "%~dp0files\Data\*" "%GAMEDIR%Data\" >nul
if errorlevel 1 goto :COPYFAIL
echo [2/3] 中文语言文件已部署

set "FONT=%~dp0ChineseFont.ttf"
if exist "!FONT!" goto :FONTOK
set "FONT=%WINDIR%\Fonts\simhei.ttf"
if exist "!FONT!" goto :FONTOK
goto :NOFONT
:FONTOK
mkdir "%GAMEDIR%Data\Gui\Fonts\english" 2>nul
for %%F in (
  FontBB2_TRUMP_TOWN_PRO
  FontBB2_OPENSANS-REGULAR
  FontBB2_OPENSANS-SEMIBOLD
  FontBB2_OPENSANS-ITALIC
  FontBB2_OPENSANS-BOLDITALIC
  FontBB2_ROBOTOCONDENSED-BOLD
  FontBB2_KELLYSLAB-REGULAR
  FontBB2_LOBSTER
  FontBB2_COURIERNEW
) do (
  copy /y "!FONT!" "%GAMEDIR%Data\Gui\Fonts\%%F.TTF" >nul
  copy /y "!FONT!" "%GAMEDIR%Data\Gui\Fonts\english\%%F.TTF" >nul
)
echo [3/3] 中文字体已部署
echo.
echo ============================================
echo   安装完成！启动游戏（语言保持 English）即为中文
echo   卸载请运行 uninstall.bat
echo ============================================
pause
exit /b 0

:NOGAME
echo [错误] 未找到 BloodBowl2.exe
echo 请把整个 BB2ChineseMod 文件夹放到游戏根目录后重试
echo （游戏根目录 = BloodBowl2.exe 所在文件夹，Steam 右键游戏 - 管理 - 浏览本地文件）
pause
exit /b 1
:BACKUPFAIL
echo [错误] 备份原始文件失败，请右键以管理员身份运行
pause
exit /b 1
:COPYFAIL
echo [错误] 复制汉化文件失败，请检查游戏目录写入权限
pause
exit /b 1
:NOFONT
echo [错误] 未找到可用中文字体
echo 请确保 ChineseFont.ttf 与本脚本在同一文件夹，或系统已安装黑体
pause
exit /b 1
