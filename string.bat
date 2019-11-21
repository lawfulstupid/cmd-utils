@echo off

:main
setlocal EnableDelayedExpansion
	set outvar=
	set args3=%*
	call drop 2 args3
	
	set switch=%~1
	call case "/?" 					&& call :help
	call case /I "/AS"				&& call :outvar "%~2" !args3!
	call default					&& call :pickOp %*
	
	set out=!%outvar%!
endlocal & if not "%outvar%"=="" set %outvar%=%out%
goto:eof


:pickOp
setlocal EnableDelayedExpansion
	set args3=%*
	call drop 2 args3
	
	set switch=%~2
	call case /I upper uppercase	&& call :uppercase "%~1"
	call case /I lower lowercase	&& call :lowercase "%~1"
	call case /I title titlecase	&& call :titlecase "%~1"
	call case /I length len			&& call :length "%~1"
	call case /I index				&& call :index "%~1" !args3!
	call default					&& call :help
	
	if not defined outvar echo !result!
endlocal & if not "%outvar%"=="" set %outvar%=%result%
goto:eof


:help
setlocal EnableDelayedExpansion
	call fx /fg:aqua
	echo STRING [/AS ^<var^>] "^<string^>" ^<operation^>
	call fx /r
	echo Performs a number of string manipulation operations.
	echo;
	echo Options:
	echo;   /AS ^<var^>		Writes the result to given variable.
	echo;
	echo Operations:
	echo;   upper		Converts the string to UPPER CASE.
	echo;   lower		Converts the string to lower case.
	echo;   title		Converts the string to Title Case.
	echo;   length		Computes string length.
	echo;   index ^<chars^>	Finds index of first instance of one of the given characters.
endlocal
goto:eof


@REM outvar <outvar> <args...>
:outvar
set args2=%*
call drop args2
set outvar=%~1
call :pickOp !args2!
goto:eof


:uppercase
setlocal EnableDelayedExpansion
	set str=%~1
	for %%C in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		set "str=!str:%%C=%%C!"
	)
endlocal & set result=%str%
goto:eof


:lowercase
setlocal EnableDelayedExpansion
	set str=%~1
	for %%C in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
		set "str=!str:%%C=%%C!"
	)
endlocal & set result=%str%
goto:eof


:titlecase
setlocal EnableDelayedExpansion
	call :lowercase "%~1"
	set head=!result:~0,1!
	set tail=!result:~1!
	set str=!result!
	for %%C in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		set head=!head:%%C=%%C!
		set tail=!tail: %%C= %%C!
		set tail=!tail:	%%C=	%%C!
	)
endlocal & set result=%head%%tail%
goto:eof


:length
setlocal EnableDelayedExpansion
	set str=%~1
	for /L %%N in (0,1,8192) do (
		if "!str!"=="" (
			set len=%%N
			goto break_len
		)
		set str=!str:~1!
	)
	:break_len
endlocal & set result=%len%
goto:eof


:index
setlocal EnableDelayedExpansion
	set str=%~1
	set opts=%*
	call drop opts
	
	set idx=
	for /L %%N in (0,1,8192) do (
		if "!str!"=="" goto break_idx
		for %%S in (!opts!) do (
			if /I "!str:~0,1!"=="%%~S" (
				set idx=%%N
				goto break_idx
			)
		)
		set str=!str:~1!
	)
	:break_idx
endlocal & set result=%idx%
goto:eof