@echo off
SETLOCAL

:: =============================================
:: Creates a backup using the NTbackup utility
:: =============================================
:: Change Log
:: =============================================
:: Date ......... Initials ........ Description
:: _____________________________________________
:: 13/Apr/2012 .. DF .............. Created.
:: =============================================

:: Check the command line arguments
IF "%~1"=="" goto Usage

SET SourceDir=%1
SET TargetDir=%2
SET TargetFile=%3
ECHO.
ECHO === Starting Daily Backup ===
ECHO.
ECHO Source Directory: %SourceDir% 
ECHO Target Directory: %TargetDir% 
ECHO Prefix for Target File: %TargetFile%

:: ------------------------------------------- Get current date and time

@For /F "tokens=1,2,3 delims=/ " %%A in ('Date /t') do @(
Set Day=%%A
Set Month=%%B
Set Year=%%C
Set All=%%C%%B%%A
)
@For /F "tokens=1,2,3 delims=:,. " %%A in ('echo %time%') do @(
Set Hour=%%A
Set Min=%%B
Set Sec=%%C
Set Allm=%%A%%B%%C
)
@For /F "tokens=3 delims=: " %%A in ('time /t ') do @(
Set AMPM=%%A
)

ECHO.
ECHO Created %Date% at %Time%

:: ------------------------------------------- Create backup

:: Create temp file with proper file names and parameters
ECHO C:\WINDOWS\system32\ntbackup.exe backup %SourceDir% /d "Created %Date% at %Time%" /v:no /r:no /rs:no /hc:off /m copy /l:s /FU /f %TargetDir:~0,-1%%TargetFile:~1,-1%_%All% %Allm%%AMPM%.bkf" > TempDailyBackup.bat

ECHO.
ECHO Created Temp Batch File
ECHO.
ECHO Contents:
ECHO =======================
type TempDailyBackup.bat
ECHO =======================

ECHO.
ECHO Executing backup using ntbackup utility

:: Call temp file
call TempDailyBackup.bat

ECHO.
ECHO Execution Complete

:: Remove temp file
if exist TempDailyBackup.bat del TempDailyBackup.bat

ECHO.
ECHO === Completed Daily Backup ===

goto End

:: ------------------------------------------- Usage
:Usage
ECHO.
ECHO DailyBackup.bat
ECHO Creates a backup using the NTbackup utility
ECHO.
ECHO Usage:  	Backup.bat [Source directory] [Target directory] [File prefix for target backup file]
ECHO Example:	Backup.bat "D:\Target" "D:\Backups\" "BackupFileName"
ECHO.
GOTO End

:End
ENDLOCAL