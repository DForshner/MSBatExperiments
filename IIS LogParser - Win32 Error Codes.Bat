@echo off
echo =============================================
echo List Win32 Error codes
echo =============================================
echo.

cd "C:\Program Files (x86)\Log Parser 2.2\"

LogParser.exe -i:W3C "SELECT sc-win32-status As Win32-Status, WIN32_ERROR_DESCRIPTION(sc-win32-status) as Description, COUNT(*) AS Hits FROM c:\inetpub\logs\LogFiles\W3SVC1\* WHERE Win32-Status<>0 GROUP BY Win32-Status ORDER BY Win32-Status ASC" -o:CSV

echo.
PAUSE
