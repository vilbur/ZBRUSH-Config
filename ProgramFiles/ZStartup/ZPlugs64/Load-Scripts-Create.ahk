#SingleInstance force

#Include %A_LineFile%\..\..\..\..\Ahk\ButtonGenerator\ButtonGenerator.ahk



$MENU	:= "~SCRIPT"
$SUBMENU	:= "Load-Plugins"
$FILE_NAME	:= "Load-Scripts.txt"

$zbrush_data := "c:\GoogleDrive\ProgramsData\CG\ZBrush"

$scripts := [	 $zbrush_data "\Config\ProgramFiles\ZScripts\TEST.txt"
	,$zbrush_data "\Config\ProgramFiles\ZStartup\ZPlugs64\UI-Labels.txt"
	,$zbrush_data "\Plugins\MaskByAlpha\MaskByAlpha.txt"
	,$zbrush_data "\Plugins\MaxZbrushSync\Lib\MaxZbrushSync.txt"]


/**
 */
getLoadScriptCommand( $script_path )
{
	$command := "[FileNameSetNext, """ $script_path """]"
	$command .= "`n	[IPress, ZScript:Load]"
	
	return $command
}


$MainButtons	:= new ButtonGenerator(128, 64)
$ScriptButtons	:= new ButtonGenerator(128, 48)

$create_menu := "[IPalette, """ $MENU """]"
$create_submenu := "`n[ISubPalette, """ $MENU ":" $SUBMENU """]"

$reload_zscripts	:= $MainButtons.create( $MENU ":RELOAD-SCRIPTS", getLoadScriptCommand( A_WorkingDir "\\" $FILE_NAME ) )
$show_script_pane	:= $MainButtons.create( $MENU ":SCRIPT", "[IPress, Zscript:Hide zscript]")




$scripts_buttons := ""

For $index, $script in $scripts
{
	SplitPath, $script, $script_name, $script_dir, $script_ext, $script_noext, $script_drive

	$scripts_buttons .= $ScriptButtons.create( $MENU ":" $SUBMENU ":" $script_noext, getLoadScriptCommand( $script ), "Reload " $script_name )
}



FileDelete, %$FILE_NAME%

FileAppend, %$create_menu%,	%$FILE_NAME%

FileAppend, %$reload_zscripts%,	%$FILE_NAME%
FileAppend, %$show_script_pane%,	%$FILE_NAME%

FileAppend, %$create_submenu%,	%$FILE_NAME%

FileAppend, %$scripts_buttons%,	%$FILE_NAME%