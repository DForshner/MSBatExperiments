@echo off
echo =============================================
echo Number of Hits per Client IP, including a Reverse DNS lookup
echo =============================================
echo.

cd "C:\Program Files (x86)\Log Parser 2.2\"

LogParser.exe -i:W3C "SELECT c-ip As Machine,  REVERSEDNS(c-ip) As Name,  COUNT(*) As Hits  FROM c:\inetpub\logs\LogFiles\W3SVC2\*  GROUP BY Machine ORDER BY Hits DESC" -o:CSV

echo.
PAUSE
