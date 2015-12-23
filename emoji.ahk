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
    IfNotExist,%ImageFile%
    {
    	clipboard = :%$1%:
      Send ^v
    }
    IfExist,%ImageFile%
    {
			CopyImg(ImageFile)
    	Send ^v
    }
return

#S::
	InputBox, emojiName, "emojis","保存图片",,50,100
	if ErrorLevel
		Return
  image = emojis\%emojiName%
	WinClip.SaveBitmap(image,"png")
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