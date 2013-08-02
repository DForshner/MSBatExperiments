@echo off
echo =============================================
echo Top 25 URLs
echo =============================================
echo.

cd "C:\Program Files (x86)\Log Parser 2.2\"

LogParser.exe -i:W3C "SELECT TOP 25 cs-uri-stem as Url, COUNT(*) As Hits FROM c:\inetpub\logs\LogFiles\W3SVC2\* GROUP BY cs-uri-stem ORDER By Hits DESC" -o:CSV

echo.
PAUSE
