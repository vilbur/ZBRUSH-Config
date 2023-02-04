


$file_path := "UI-BUTTONS.txt"


FileDelete, %$file_path%



Loop, 20
{
   ;MsgBox, %A_Index%

   ;$menu_path	:= ""
   $menu_path := "~VIL-PLUGINS:Mask By Alpha-Buttons:"


   $btn_name	:= "Mask " A_Index
   $tooltip	:= "Load Alpha " A_Index " as mask"

   $enabled := "1"
   ;$enabled := ""

   ;$command	:= "[Note, Test " A_Index "]"
   $command	:= "[RoutineCall, maskLoad, " A_Index "]"

   $width	:= "56"
   $height	:= "48"


   $button	:= "[IButton, """ $menu_path $btn_name """, """ $tooltip """,	" $command ",	" $enabled ", " $width ",,, " $height "]`n"

   ;A_Index
   ;MsgBox,262144,button, %$button%,3
   FileAppend, %$button%, %$file_path%
}
