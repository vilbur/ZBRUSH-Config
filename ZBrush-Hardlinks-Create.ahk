#SingleInstance force

/** -------------------------------------------
  *
  *    CREATE HARDLINK FOR FILES AND FOLDERS
  *
  * -------------------------------------------
  */


/** Array of source paths for hardlinks
  *
  *	Path will be replace by paths
  *
  */
$source_paths := [ "ProgramFiles/ZScripts", "ProgramFiles/ZStartup/ZPlugs64", "AppData/ZStartup"  ]



/** 2D Array of strings [ "{search}", "{repalce}" ]
  *
  *	Paths in $source_paths will be modified to get target path for hardlink
  *
  * E.G.:
  * 	"AppData/scripts" >>> "C:/Users/%username%/AppData/Local/Autodesk/3dsMax/2023 - 64bit/ENU/scripts"
  *
  */
;$search_and_replaces_R6 := [ [ "ProgramFiles", "C:/Program Files (x86)/Pixologic/ZBrush 4R6" ],[ "AppData", "C:/Users/Public/Documents/ZBrushData" ] ]
$search_and_replaces_2022 := [ [ "ProgramFiles", "C:/Program Files/Pixologic/ZBrush 2022" ],[ "AppData", "C:/Users/Public/Documents/ZBrushData2022" ] ]


/** isHardlink
 */
isHardlink( $path )
{
	SplitPath, $path, $dir_name, $path_parent

	objShell.Exec(comspec " /c dir /al /s c:\*.*")
	;MsgBox,262144,dir_name, %$dir_name%
	$objShell	:= ComObjCreate("WScript.Shell")
	$objExec	:= $objShell.Exec(comspec " /c dir """ $path_parent """ | find /i ""<SYMLINK""")

	$objExec_result := $objExec.StdOut.ReadAll()
	;MsgBox,262144,objExec_result, %$objExec_result%
	return RegExMatch( $objExec_result, "<SYMLINKD*>\s+" $dir_name ) ? 1 : 0
}

/** CREATE HARDLINKS TOS ZBRUSH
 */
createHardlinks( $path_source, $path_link_target )
{

	;MsgBox,262144,path_link_target, %$path_link_target%
	;MsgBox,262144,mklink, % isHardlink($path_link_target)

	if ( ! isHardlink($path_link_target) )
	{
		$path_target_bak	:= $path_link_target ".default"

		$is_folder := InStr( FileExist($path_source), "D" ) != 0


		/**  Backup original file or folder
		  */
		if( FileExist( $path_link_target ) && ! FileExist( $path_target_bak ) )
		{
			if( $is_folder )
				FileMoveDir, % $path_link_target, % $path_target_bak
			else
				FileCopy, % $path_link_target, % $path_target_bak
		}

		$file_or_folder	:= $is_folder ? "/d" : ""


		$mklink	:= "mklink " $file_or_folder " """ $path_link_target """ """ $path_source """"
		;MsgBox,262144,mklink, %$mklink%

		RunWait %comspec% /c %$mklink%,,Hide
	}
}

/** LOOP SOURCE PATHS
 */
loopDirectoriesAndCreateHardlinks($source_paths, $search_and_replaces)
{
	;MsgBox,262144,search_and_replaces, % $search_and_replaces[1][1]

	For $index, $path in $source_paths
	{
		$dir_split	:= StrSplit( $path, "/",, 2 )
		;MsgBox,262144,path, %$path%

		For $i, $search_and_replace in $search_and_replaces
		{
			;MsgBox,262144,search_and_replace, %$search_and_replace%
			if( $dir_split[1] == $search_and_replace[1] )
			{
				$search	:= $search_and_replace[1]
				$replace	:= $search_and_replace[2]
			}
		}

		if( $search !="" && $replace !="" )
		{
			$path_link_source := A_WorkingDir "/" $path
			$path_link_target :=  StrReplace( $path, $search, $replace )

			$path_link_source	:= RegExReplace( $path_link_source, "/", "\") ;"
			$path_link_target	:= RegExReplace( $path_link_target, "/", "\") ;"

			if( FileExist( $path_link_source ) )
				createHardlinks( $path_link_source,	$path_link_target )
			else
				MsgBox,262144, PATH DOES NOT EXISTS, % "PATH DOES NOT EXISTS:`n`n" $path_link_source
		}
	}
}

/** EXECUTE
  *
  */
loopDirectoriesAndCreateHardlinks($source_paths, $search_and_replaces_2022)

;MsgBox,262144, SUCCESS, Hardlinks created