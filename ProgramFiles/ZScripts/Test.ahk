#SingleInstance force

$path := "c:\\Users\\Public\\Documents\\ZBrushData2022\\ZPluginData\\DecimationMasterData"
	count = 0
	Loop, % $path "\\*.zpm", 1, 0
		 count++

MsgBox,262144,count, %count%,3

	;return % count