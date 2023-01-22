#SingleInstance force



/**
 */
createHardlinksForDirectories( $dir_source, $dir_target )
{
	Loop, Files, % $dir_source "\*" , D
	{
		$path_source	:= $dir_source "/" A_LoopFileName
		$path_target	:= $dir_target "/" A_LoopFileName
		$path_target_bak	:= $path_target ".default"

		if( FileExist( $path_target ) && ! FileExist( $path_target_bak ) )
			FileMoveDir, %$path_target%, % $path_target_bak

		$mklink	:= "mklink " "/d" " """ $path_target """ """ $path_source """"

		RunWait %comspec% /c %$mklink%,,Hide
	}
}



createHardlinksForDirectories( A_WorkingDir "/AppData",	"C:/Users/Public/Documents/ZBrushData2022" )
createHardlinksForDirectories( A_WorkingDir "/ProgramFiles",	"C:/Program Files/Maxon ZBrush 2022" )

MsgBox,262144, SUCCESS, Hardlinks created,3
