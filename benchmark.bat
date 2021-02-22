@echo off
setlocal
call now STARTTIME
%*
call now ENDTIME
echo.
echo Started:  %STARTTIME%
echo Ended:    %ENDTIME%

rem calculating the duratyion is easy
set /A DURATION=%ENDTIME%-%STARTTIME%

rem we might have measured the time inbetween days
if %ENDTIME% LSS %STARTTIME% set set /A DURATION=%STARTTIME%-%ENDTIME%

rem now break the milliseconds down to hours, minutes, seconds and the remaining milliseconds
set /A DURATIONH=%DURATION% / 3600000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 60000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 1000
set /A DURATIONMS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)

rem some formatting
if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONMS% LSS 10 set DURATIONMS=0%DURATIONMS%

rem outputing
echo Duration: %DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONMS%

endlocal
goto:eof