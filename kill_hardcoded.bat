@echo off

:: Define your list of process you want to kill right here, separated by spaces
set "procList=AdobeCollabSync.exe PSExpressBroker.exe PSExpressCore.exe PowerToys.exe sl-browser-service.exe ielowutil.exe Spotify.exe"

echo Terminating pre-defined process trees...
echo -----------------------------------------------------

:: Loop through the hardcoded list
for %%P in (%procList%) do (
    echo.
    echo Target: %%P
    taskkill /f /t /im "%%P"
)

echo -----------------------------------------------------
echo Done!
pause