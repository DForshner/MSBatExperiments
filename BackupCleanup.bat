@echo off
SETLOCAL

:: =============================================
:: This batch file deletes files with a specified 
:: extension which are older than a specified 
:: number of days.
:: =============================================
:: Change Log
:: =============================================
:: Date ......... Initials ........ Description
:: _____________________________________________
:: 13/Apr/2012 .. DF .............. Created.
:: =============================================

:: Check the command line arguments
IF "%~1"=="" goto Usage

SET TargetDir=%1
SET TargetExt=%2
SET Age=%3
ECHO.
ECHO === Starting Daily Backup Cleanup ===
ECHO.
ECHO Target Directory: %TargetDir% 
ECHO Target File Extension: %TargetExt%
ECHO Deleting any files older than %Age% day old

:: ------------------------------------------- Delete old files

:: Create temp file with proper file names and parameters
ECHO forfiles /p %TargetDir:~1,-1% /s /m *.%TargetExt:~1,-1% /d -%Age:~1,-1% /c "cmd /c echo Deleting file: @file" > TempDailyBackupCleanup.bat
ECHO forfiles /p %TargetDir:~1,-1% /s /m *.%TargetExt:~1,-1% /d -%Age:~1,-1% /c "cmd /c del @file" >> TempDailyBackupCleanup.bat

ECHO.
ECHO Created Temp Batch File
ECHO.
ECHO Contents:
ECHO =======================
TYPE TempDailyBackupCleanup.bat
ECHO =======================

ECHO.
ECHO Executing ...

:: Call temp file
call TempDailyBackupCleanup.bat

ECHO.
ECHO Execution Complete

:: Remove temp file
if exist TempDailyBackupCleanup.bat del TempDailyBackupCleanup.bat

ECHO.
ECHO === Completed Daily Backup Cleanup ===

goto End

:: ------------------------------------------- Usage
:Usage
ECHO.
ECHO BackupCleanup.bat
ECHO This batch file deletes files with a specified extension which are older than a specified number of days.
ECHO.
ECHO Usage:  	BackupCleanup.bat [Target directory] [File extension] [Age]
ECHO Example:	BackupCleanup.bat "E:\Backup\" "bkf" "7"
ECHO.
GOTO End

:End
ENDLOCAL