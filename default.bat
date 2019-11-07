@if not "%SWITCH%"=="UNDEFINED" (
    @set SWITCH=UNDEFINED
    @exit /b 0
) else (
	@exit /b 1
)