@echo off
echo =============================================
echo Find Slowest 25 URLs
echo =============================================
echo.

cd "C:\Program Files (x86)\Log Parser 2.2\"

LogParser.exe -i:W3C "SELECT TOP 25 cs-uri-stem as URL, MAX(time-taken) As Max, MIN(time-taken) As Min, Avg(time-taken) As Average FROM c:\inetpub\logs\LogFiles\W3SVC2\* GROUP BY URL ORDER By Average DESC" -o:CSV

echo.
PAUSE
