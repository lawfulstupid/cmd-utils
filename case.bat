@if %~2 "%SWITCH%"=="%~1" (
	@default
) else (
	@exit /b 1
)