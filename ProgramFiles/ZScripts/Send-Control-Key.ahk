#SingleInstance force

if( $zbrush_window := WinExist( "ahk_exe ZBrush.exe" ) )
{
	WinActivate, ahk_exe ZBrush.exe

	sleep 500
	Send, {Ctrl Down}
	sleep 500
	Send, {Ctrl Up}
}
