@echo off
Setlocal enabledelayedexpansion

:choice
	echo Batch Rename Miro Video Output - By Timothy S. Murphy
	echo Instructions: Place this file in your Miro Video Converter Output Directory 
	echo               - Windows: C:\Users\{{Username}}\Videos\Miro Video Converter
	echo ----------------------------------------------------------------
	echo Enter "Y" to rename files
	echo Enter "N" to view, but not rename, files that match rename rules
	echo ----------------------------------------------------------------
	echo.
	set /P c=Are you sure you want to continue[Y/N]?   
	if /I "%c%" EQU "Y" goto :pickyes
	if /I "%c%" EQU "N" goto :pickno
goto :choice

:pickyes
Set "VerifyRename=true"
goto :startrename

:pickno
Set "VerifyRename=false"

:startrename

Set "Pattern=rename"
Set "Replace=reuse"
Set "MiroDoubleExtensions=*.mp4.mp4 *.webmhd.webm *.webmsd.webm *.oggtheora.ogv"

echo Start...
For %%a in (%MiroDoubleExtensions%) Do (
	Set "FileOrig=%%~a"
	Set "FileName=%%~na"
	Set "FileExt=%%~xa"

	REM echo %%a --- %%~na --- %%~xa
	set FileName=!FileName:.mp4=!
	set FileName=!FileName:.webmhd=!
	set FileName=!FileName:.webmsd=!
	set FileName=!FileName:.oggtheora=!

	echo !FileOrig! --- !FileName!!FileExt!
	if /i "%VerifyRename%" EQU "true" (
		Ren "!FileOrig!" "!FileName!!FileExt!"
	)
)

echo ...End.
pause
exit