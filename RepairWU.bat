@ECHO OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    GOTO Repair
) ELSE (
    ECHO You need to run this as Administrator.
)
:Repair
CD /d %windir%
START /WAIT sc stop bits
START /WAIT sc stop wuauserv
MOVE "SoftwareDistribution" "SoftwareDistribution.bak"
START /WAIT sc start wuauserv
START /WAIT sc start bits
