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
global $source_paths := [	"AppData/ZStartup"
	,"ProgramFiles/ZScripts"

						 ,"ProgramFiles/ZStartup/ZPlugs64/UI-Labels.zsc"]


/** 2D Array of strings [ "{search}", "{repalce}" ]
  *
  *	Paths in $source_paths will be modified to get target path for hardlink
  *
  * E.G.:
  * 	"AppData/scripts" >>> "C:/Users/%username%/AppData/Local/Autodesk/3dsMax/2023 - 64bit/ENU/scripts"
  *
  */
global $search_and_replaces := [ [ "ProgramFiles", "C:/Program Files/Pixologic/ZBrush 2022" ],[ "AppData", "C:/Users/Public/Documents/ZBrushData2022" ] ]


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
createHardlinks( $path_source, $path_link )
{
	$is_folder := InStr( FileExist($path_source), "D" ) != 0

	;MsgBox,262144,path_source, %$path_source%
	;MsgBox,262144,path_link, %$path_link%
	;MsgBox,262144,isHardlink, % ! isHardlink($path_link)


	if ( ! isHardlink($path_link) )
	{
		/*
			BACKUP ORIGINAL FILES & FODLERS
		*/
		$path_target_bak	:= $path_link ".default"

		/**  Backup original file or folder
		  */
		if( FileExist( $path_link ) && ! FileExist( $path_target_bak ) )
		{

			if( $is_folder )
				FileMoveDir, %$path_link%, %$path_target_bak%
			else
				FileMove, %$path_link%, %$path_target_bak%
		}
	}

	/*
		REMOVE OLD OCCURENCES
	*/
	if( $is_folder )
		FileRemoveDir, %$path_link%

	else
		FileDelete, %$path_link%


	$file_or_folder	:= $is_folder ? "/d" : ""

	$mklink	:= "mklink " $file_or_folder " """ $path_link """ """ $path_source """"

	RunWait %comspec% /c %$mklink%,,Hide

}

/** LOOP SOURCE PATHS
 */
loopDirectoriesAndCreateHardlinks()
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
			$path_source := A_WorkingDir "/" $path
			$path_link :=  StrReplace( $path, $search "/", $replace "/" )

			$path_source	:= RegExReplace( $path_source, "/", "\") ;"
			$path_link	:= RegExReplace( $path_link, "/", "\") ;"

			;MsgBox,262144,path_source, %$path_source%
			;MsgBox,262144,path_link, %$path_link%


			if( FileExist( $path_source ) )
				createHardlinks( $path_source,	$path_link )
			else
				MsgBox,262144, PATH DOES NOT EXISTS, % "PATH DOES NOT EXISTS:`n`n" $path_source
		}
	}
}

/** EXECUTE
  *
  */
loopDirectoriesAndCreateHardlinks()

;MsgBox,262144, SUCCESS, Hardlinks created