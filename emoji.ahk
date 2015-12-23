#NoEnv
#SingleInstance force
#Include WinClipAPI.ahk	; http://www.autohotkey.com/board/topic/74670-class-winclip-direct-clipboard-manipulations/
#Include WinClip.ahk
#Include HotStrings.ahk
SetBatchLines, -1

hotstrings(":(.+):", "emoji")
Return

emoji:
    ImageFile = emojis\%$1%.png
    IfNotExist,%ImageFile%
    	ImageFile = emojis\%$1%.gif
		IfNotExist,%ImageFile%
    	ImageFile = emojis\%$1%.jpg
		CopyImg(ImageFile)
    Send ^v
return

#O::
  baseDir = E:\github\ahkemoji\emojis
	InputBox, emojiName, "emojis","emojis表情",,50,100
	if ErrorLevel
		Return
  ImageFile = %baseDir%\%emojiName%
	CopyImg(ImageFile)
  Send ^v
	;ToolTip, % "`n`n" A_Tab "Copied!" A_Tab A_Tab "`n`n"
	;Sleep, 2000
	;ToolTip
Return

CopyImg(ImageFile)
{
	; Expand to full path
	if !RegExMatch(ImageFile, "i)^(https?|ftp)://")
	{
		Loop, %ImageFile%
			ImageFile := A_LoopFileLongPath
	}

	html =
	(LTrim
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
		<HTML><HEAD></HEAD>
		<BODY><!--StartFragment--><IMG src="%ImageFile%"><!--EndFragment--></BODY>
		</HTML>
	)

	WinClip.Clear()
	WinClip.SetHTML( html )

	if RegExMatch(ImageFile, "i)^(https?|ftp)://")
		return

	WinClip.SetFiles( ImageFile )
	WinClip.SetBitmap( ImageFile )
	return
}