@ECHO OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    GOTO Repair
) ELSE (
    ECHO You need to run this as Administrator.
)

:Repair
FOR /F "tokens=2 delims==" %%I IN ('wmic os get localdatetime /value ^| find "="') DO SET datetime=%%I
SET current_date=%datetime:~0,12%
SET current_date=%current_date:/=-%

CD /d %windir%
START /WAIT sc stop bits
START /WAIT sc stop wuauserv
START /WAIT sc stop cryptsvc
MOVE SoftwareDistribution SoftwareDistribution_%current_date%.bak

CD /d %windir%\system32
MOVE catroot2 catroot2_%current_date%.bak

START /WAIT sc start wuauserv
START /WAIT sc start bits
START /WAIT sc start cryptsvc
pause