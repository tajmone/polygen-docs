@ECHO OFF
:: Delete all third party tools files downloaded and extracted via "download.bat"
ECHO.
ECHO ==============================================================================
ECHO WARNING --- THIS WILL DELETE ALL DOWNLOADED RESOURCES!!!
ECHO ==============================================================================
ECHO.
CHOICE /C YN /T 5 /D N /M "DO YOU REALLY WANT TO PROCEED?"
IF ERRORLEVEL 2 ECHO ABORTING... & EXIT /B

ECHO.
DEL *.zip
DEL *.7z
DEL *.exe
DEL *.dll
DEL *.conf
RD /S /Q langDefs
RD /S /Q themes

EXIT /B