@ECHO OFF
REM // Default Language of created 'tracks'
REM ++ Leave as is to set English flag
	SET "lang=eng"
REM @@ blank: SET "lang=eng"
REM // =======================
REM || Batch Subtitle Muxing
REM ||       for MKVmerge
REM || v0.4-20150511 by drudge
REM \\ =======================
REM @@ This batch script will scan the provided directory (or current folder)
REM @@ for video files, attempt to match them with subtitle files,
REM @@ and mux them using the MKVmerge command line.
REM	// ---- ---- ---- ----
REM || USER CONFIGURATION
REM // full path to mkvmerge.exe
	SET "muxpath=C:\Program Files\MKVToolNix\mkvmerge.exe"
REM \\ -- -- -- -- --
REM // full path to unrar program, make sure to include switches
	SET "rarpath=C:\Program Files\7-Zip\7z.exe"
	SET "rarcmd=e"
REM \\ -- -- -- -- --
REM // output path (with trailing slash)
REM ++ leave blank for working directory
	SET "outputdir="
REM @@ default: SET "outputdir="
REM \\ -- -- -- -- --
REM // prepend text to output filename
REM ++ REQUIRED if outputdir is left blank
	SET "fileprefix=subtitled-"
REM @@ blank: SET "fileprefix="
REM \\ -- -- -- -- --
REM || END USER CONFIG
REM \\ ---- ---- ---- ----
REM -- editing below this line should be done precisely. (here thar be dragons)
REM ===========================================================================

REM @@ simple counters
SET /A "mc=0"
SET /A "me=0"

REM @@ default working path
SET "wp=."

REM @@ optional working path via argument
IF EXIST "%~1" SET "wp=%~1"

REM @@ ready steady go!
CLS
ECHO ===========================================================================

REM @@ attempt to use custom setting for output path
IF EXIST "%outputdir%" (
	REM @@ user has provided output path
	ECHO == User Setting -- Output to: [%outputdir%]
) ELSE (
	REM @@ no custom setting, check for prefix
	IF [%fileprefix%]==[] (
		ECHO @@ ERROR: empty [fileprefix] setting requires [outputdir] to be set
		SET /A me+=1
		GOTO:done
	)
	REM @@ use working path for output
	SET "outputdir=%wp%\"
)
FOR %%H IN ("%wp%") DO (
	REM @@ because "." doesn't tell us where we are
	ECHO == Scanning [%%~dpfH\] for video files...
)

:getfiles
FOR %%I IN ("%wp%\*.avi",
REM			"%wp%\*.customVideoExtension",
			"%wp%\*.mkv",
			"%wp%\*.mp4") DO (
	REM @@ found a video file, now check for subtitles
	CALL:getsubs "%%~I"
)
GOTO:done

:getsubs
FOR %%J IN ("%wp%\%~n1.idx",
REM			"%wp%\%~n1.customSubtitleExtension",
			"%wp%\%~n1.ass") DO (
REM @@ check for paired subtitle files. USF/XML may require this check as well
	IF %%~xJ==.idx IF EXIST "%wp%\%%~nJ.idx" IF NOT EXIST "%wp%\%%~nJ.sub" (
		IF EXIST "%wp%\%%~nJ.rar" (
			ECHO -- [%%~nJ.sub] -- Found potential .rar
			ECHO | SET /p extdone=">> "
			"%rarpath%" "%rarcmd%" "%%~dpJ%%~nJ.rar" | FIND "Extracting"
		) ELSE (
			ECHO @@ ERROR: [%%~nJ.idx] -- Missing .sub file
			SET /A me+=1
			GOTO:eof
		)
	)
REM @@ subtitle found, time to put it all together
	IF EXIST "%wp%\%%~nJ%%~xJ" CALL:muxit "%%~f1" "%%~xJ"
)
GOTO:eof

:muxit
REM @@ make sure the destination file doesn't exist first
IF EXIST "%outputdir%%fileprefix%%~n1%~x1" (
	ECHO @@ ERROR: [%~n1%~x1] -- Existing output file
	SET /A me+=1
	GOTO:eof
)

REM @@ we've made it!
SET /A mc+=1
REM @@ now we let mkvmerge work its magic
ECHO | SET /p muxdone="++ Muxing: (%mc%) [%~n1%~x1]"
"%muxpath%" --default-language "%lang%" -q -o "%outputdir%%fileprefix%%~n1%~x1" "%~1" "%wp%\%~n1%~2"
ECHO  ..complete
REM @@ success!
GOTO:eof

:done
ECHO == Finished Processing: %mc% completed / %me% errors
ECHO ===========================================================================
REM @@ game over, man
pause