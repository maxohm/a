@rem ***************************************************
@rem *** Copyright (c) 2017, maxohm [ at ] gmail.com ***
@rem ***************************************************

@echo off

:stage0
set xTASK=%0
set xHEAD="net.exe"
for /f %%I in ("%xTASK%") do (
	set xTSDISK=%%~dI
	set xTSPATH=%%~dpI
	set xTSNAME=%%~nI
)

:stage1
call %xTSPATH%\stage1s.cmd %1 %2 %3 %4
if %ERRORLEVEL% NEQ 0 (
	set x > %xLOGFILE%
	echo ERROR %ERRORLEVEL% >> %xLOGFILE%
	exit /B %ERRORLEVEL%
)

:stage5
set x > %xLOGFILE%
for /f "eol=# tokens=1,2 delims=	" %%u in (%xOBJECT%) do (
	if exist \\127.0.0.1\homes\%%u (
		%xSUBJECT% user %%u %%v > nul
		echo -----------------------------------------I------------------------------------- >> %xLOGFILE%.passwd
		echo ��ࠬ���� ����㯠 ���� ����祭�.         I ID     : %%u >> %xLOGFILE%.passwd
		echo � �ࠢ����� �ᯮ�짮����� � ࠡ��� �     I ��஫� : %%v >> %xLOGFILE%.passwd
		echo ��⥬� ���������� � ������� �ᯮ�����. I ���   : %DATE% >> %xLOGFILE%.passwd
		echo                                          I >> %xLOGFILE%.passwd
		echo ID %%u ������� ________ ��� ________ >> %xLOGFILE%.passwd
		echo                                          I >> %xLOGFILE%.passwd
		echo �����஢�� ____________________________ I >> %xLOGFILE%.passwd
		echo -----------------------------------------I------------------------------------- >> %xLOGFILE%.passwd
	) else (
		%xSUBJECT% user %%u %%v /add > /nul
		%xSUBJECT% user %%u /expires:never /passwordreq:yes /passwordchg:no /active:yes >> %xLOGFILE%
		%xSUBJECT% user %%u /comment:%%u /fullname:%%u /usercomment:%%u >> %xLOGFILE%
		if exist \\127.0.0.1\homes mkdir \\127.0.0.1\homes\%%u >> %xLOGFILE%
		if exist \\127.0.0.1\homes\%%u %xSUBJECT% user %%u /profilepath:\\127.0.0.1\homes\%%u >> %xLOGFILE%
:stage4
		if %xNULPRM4%==.nul (
			rem
		) else (
			%xSUBJECT% localgroup %xTSPRM4% %%u /add >> %xLOGFILE%
		)
	)
)

exit /B 0