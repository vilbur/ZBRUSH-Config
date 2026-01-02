#SingleInstance force

#Include %A_LineFile%\..\..\ButtonGenerator.ahk



$ButtonGenerator := new ButtonGenerator()


$button := $ButtonGenerator.create("Defaults", "[Note, ""Defaults""]")


$button_params := $ButtonGenerator.create("Params", "", "Disabled with tooltip", 1)


$button_icon := $ButtonGenerator.create( "Icon Button", "[Note, ""Hot Key Test""]", "CTRL+SHIFT+ALT+'Q'" )


$ButtonGenerator.width	:= 64
$ButtonGenerator.height	:= 64

$button_icon := $ButtonGenerator.create( "Icon Button", "", "",  "", "", A_WorkingDir "\icon.psd"  )



/** WRITE TO FILE
  *	
  */
$FILE_PATH	:= "Test-Result.txt"

FileDelete, %$FILE_PATH%

FileAppend, %$button%,	%$FILE_PATH%
FileAppend, %$button_params%,	%$FILE_PATH%
FileAppend, %$button_icon%,	%$FILE_PATH%