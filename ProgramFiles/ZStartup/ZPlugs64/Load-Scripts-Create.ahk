#SingleInstance force

#Include %A_LineFile%\..\..\..\..\Ahk\ButtonGenerator\ButtonGenerator.ahk


/**
 */
getLoadScriptCommand( $script_path )
{
	$command := "[FileNameSetNext, """ $script_path """]"
	$command .= "`n	[IPress, ZScript:Load]"
	
	return $command
}

$MENU	:= "~SCRIPT"
$SUBMENU	:= "Load-Plugins"
$FILE_NAME	:= "Load-Scripts.txt"

$zbrush_data := "c:\GoogleDrive\ProgramsData\CG\ZBrush"

$scripts := [	 $zbrush_data "\Config\ProgramFiles\ZScripts\TEST.txt"
	,$zbrush_data "\Config\ProgramFiles\ZStartup\ZPlugs64\UI-Labels.txt"
	,$zbrush_data "\Plugins\MaskByAlpha\MaskByAlpha.txt"
	,$zbrush_data "\Plugins\MaxZbrushSync\Lib\MaxZbrushSync.txt"]


$create_menu := "[IPalette, """ $MENU """]"
$create_submenu := "`n[ISubPalette, """ $MENU ":" $SUBMENU """]"



$MainButtons	:= new ButtonGenerator(128, 64)
$ScriptButtons	:= new ButtonGenerator(128, 48)

$zscript_btn	:= $MainButtons.create( $MENU ":SCRIPT", "[IPress, Zscript:Hide zscript]")
$load_zscript_btn	:= $MainButtons.create( $MENU ":RELOAD-SCRIPTS", getLoadScriptCommand( A_WorkingDir "\\" $FILE_NAME ) )


$scripts_buttons := ""

For $index, $script in $scripts
{
	SplitPath, $script, $script_name, $script_dir, $script_ext, $script_noext, $script_drive
	;StringUpper, $script_noext, $script_noext

	$scripts_buttons .= $ScriptButtons.create( $MENU ":" $SUBMENU ":" $script_noext, getLoadScriptCommand( $script ) )
}



FileDelete, %$FILE_NAME%


FileAppend, %$create_menu%,	%$FILE_NAME%

FileAppend, %$load_zscript_btn%,	%$FILE_NAME%
FileAppend, %$zscript_btn%,	%$FILE_NAME%


FileAppend, %$create_submenu%,	%$FILE_NAME%

FileAppend, %$scripts_buttons%,	%$FILE_NAME%